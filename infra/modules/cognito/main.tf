# Create a Cognito User Pool
resource "aws_cognito_user_pool" "user_pool" {
  name = var.user_pool_name

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  alias_attributes = ["preferred_username"]

  auto_verified_attributes = []

  mfa_configuration = "OFF"

  username_configuration {
    case_sensitive = true
  }

  # Required attributes
  schema {
    attribute_data_type = "String"
    name                = "name"
    required            = true
    mutable             = true
  }

  # Custom attribute
  schema {
    attribute_data_type      = "String"
    name                     = "cpf"
    required                 = false
    mutable                  = true
    developer_only_attribute = false
    string_attribute_constraints {
      min_length = 11
      max_length = 11
    }
  }

  # Self-registration
  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  # Account recovery 
  account_recovery_setting {
    recovery_mechanism {
      name     = "admin_only"
      priority = 1
    }
  }

  # Lambda trigger
  lambda_config {
    pre_token_generation = var.lambda_function_arn
  }

  tags = {
    Name = var.user_pool_name
  }
}

# Create a Cognito User Pool Client
resource "aws_cognito_user_pool_client" "client" {
  name            = var.client_name
  user_pool_id    = aws_cognito_user_pool.user_pool.id
  generate_secret = false

  allowed_oauth_flows_user_pool_client = true
  explicit_auth_flows                  = ["ALLOW_ADMIN_USER_PASSWORD_AUTH", "ALLOW_CUSTOM_AUTH", "ALLOW_USER_SRP_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]

  allowed_oauth_flows           = ["code", "implicit"]
  allowed_oauth_scopes          = ["openid", "profile", "email"]
  callback_urls                 = var.callback_urls
  supported_identity_providers  = ["COGNITO"]
  prevent_user_existence_errors = "ENABLED"
}

# Create a admin group
resource "aws_cognito_user_group" "admin_group" {
  name         = "admin-group"
  user_pool_id = aws_cognito_user_pool.user_pool.id
  description  = "Administrators group"
}

# Create a customer group
resource "aws_cognito_user_group" "customer_group" {
  name         = "customer-group"
  user_pool_id = aws_cognito_user_pool.user_pool.id
  description  = "Customers group"
}

# Create a Cognito User Pool Domain
resource "aws_cognito_user_pool_domain" "user_pool_domain" {
  domain       = var.user_pool_domain_prefix
  user_pool_id = aws_cognito_user_pool.user_pool.id
}

# Create a Cognito UI Customization
resource "aws_cognito_user_pool_ui_customization" "ui_customization" {
  user_pool_id = aws_cognito_user_pool.user_pool.id
  client_id    = aws_cognito_user_pool_client.client.id
  css          = "/* Custom CSS for Cognito Hosted UI */"
}

# Create a Cognito Risk Configuration
resource "aws_cognito_risk_configuration" "risk_configuration" {
  user_pool_id = aws_cognito_user_pool.user_pool.id
  client_id    = aws_cognito_user_pool_client.client.id

  compromised_credentials_risk_configuration {
    actions {
      event_action = "NO_ACTION"
    }
  }

  account_takeover_risk_configuration {
    actions {
      low_action {
        event_action = "NO_ACTION"
        notify       = false
      }
      medium_action {
        event_action = "NO_ACTION"
        notify       = false
      }
      high_action {
        event_action = "NO_ACTION"
        notify       = false
      }
    }

    notify_configuration {
      from       = "no-reply@yourdomain.com" # Remetente do e-mail
      reply_to   = "support@yourdomain.com"  # E-mail de resposta
      source_arn = aws_cognito_user_pool.user_pool.arn
      block_email {
        subject   = "Account Blocked"
        html_body = "Your account has been blocked due to suspicious activity."
        text_body = "Your account has been blocked due to suspicious activity."
      }
      mfa_email {
        subject   = "MFA Verification"
        html_body = "Your account requires MFA verification."
        text_body = "Your account requires MFA verification."
      }
      no_action_email {
        subject   = "Account Notification"
        html_body = "This is a notification of no suspicious activity."
        text_body = "This is a notification of no suspicious activity."
      }
    }
  }
}

# Create a Cognito Identity Pool
resource "aws_cognito_identity_pool" "identity_pool" {
  identity_pool_name               = var.identity_pool_name
  allow_unauthenticated_identities = false
  cognito_identity_providers {
    client_id     = aws_cognito_user_pool_client.client.id
    provider_name = aws_cognito_user_pool.user_pool.endpoint
  }
}
