provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "aws-fastfood-terraform-tfstate"
    key    = "fast-food-auth/terraform.tfstate"
    region = "us-east-1"
  }
}

module "cognito" {
  source            = "./modules/cognito"
  user_pool_name    = var.user_pool_name
  client_name       = var.client_name
  callback_urls = var.callback_urls
  identity_pool_name = var.identity_pool_name
  authenticated_role_arn = aws_secretsmanager_secret_version.auth_role.secret_string["authenticated_role_arn"]
  unauthenticated_role_arn = aws_secretsmanager_secret_version.auth_role.secret_string["unauthenticated_role_arn"]
}

# Configuração para o AWS Secrets Manager
resource "aws_secretsmanager_secret" "auth_role" {
  name = "cognito-auth-roles"
}

resource "aws_secretsmanager_secret_version" "auth_role" {
  secret_id = aws_secretsmanager_secret.auth_role.id
  secret_string = jsonencode({
    authenticated_role_arn    = var.authenticated_role_arn
    unauthenticated_role_arn  = var.unauthenticated_role_arn
  })
}