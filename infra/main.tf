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

# Connect the Cognito module
module "cognito" {
  source            = "./modules/cognito"
  user_pool_name    = var.user_pool_name
  client_name       = var.client_name
  callback_urls = var.callback_urls
  identity_pool_name = var.identity_pool_name
}

# Connect the Lambda module
module "lambda" {
  source      = "./modules/lambda"
  lambda_name = var.lambda_name
}