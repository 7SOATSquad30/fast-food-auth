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

# Connect the Lambda module
module "lambda" {
  source      = "./modules/lambda"
  lambda_name = var.lambda_name
}

# Connect the Cognito module
module "cognito" {
  source                  = "./modules/cognito"
  user_pool_name          = var.user_pool_name
  user_pool_domain_prefix = var.user_pool_domain_prefix
  client_name             = var.client_name
  callback_urls           = var.callback_urls
  lambda_function_arn     = module.lambda.lambda_function_arn
  identity_pool_name      = var.identity_pool_name

  depends_on = [module.lambda]
}

# Connect the API Gateway module
module "api_gateway" {
  source               = "./modules/api_gateway"
  api_name             = var.api_name
  stage_name           = var.stage_name
  vpc_link_name        = var.vpc_link_name
  issuer_url_endpoint  = var.issuer_url_endpoint
  issuer_url_user_pool = module.cognito.user_pool_id
  audience             = module.cognito.client_id

  depends_on = [module.cognito]
}
