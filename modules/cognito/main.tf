resource "aws_cognito_user_pool" "user_pool" {
  name = var.user_pool_name

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  auto_verified_attributes = ["email"]
  tags = {
    Name = var.user_pool_name
  }
}

resource "aws_cognito_user_pool_client" "client" {
  name         = var.client_name
  user_pool_id = aws_cognito_user_pool.user_pool.id
  generate_secret = true

  allowed_oauth_flows_user_pool_client = true
  explicit_auth_flows = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]

  allowed_oauth_flows       = ["code", "implicit"]
  allowed_oauth_scopes      = ["email", "openid"]
  callback_urls             = var.callback_urls
  supported_identity_providers = ["COGNITO"]
}

resource "aws_cognito_identity_pool" "identity_pool" {
  identity_pool_name               = var.identity_pool_name
  allow_unauthenticated_identities = false
  cognito_identity_providers {
    client_id      = aws_cognito_user_pool_client.client.id
    provider_name  = aws_cognito_user_pool.user_pool.endpoint
  }
}
