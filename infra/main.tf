provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "aws-fastfood-terraform-tfstate"
    key    = "fast-food-auth/terraform.tfstate"
    region = var.aws_region
  }
}

# Connect the Cognito module
module "cognito" {
  source             = "./modules/cognito"
  user_pool_name     = var.user_pool_name
  client_name        = var.client_name
  callback_urls      = var.callback_urls
  identity_pool_name = var.identity_pool_name
}

# Connect the Lambda module
module "lambda" {
  source      = "./modules/lambda"
  lambda_name = var.lambda_name
}

# Create a Lambda permission
resource "aws_lambda_permission" "api_gateway_invoke_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.lambda_function_arn
  principal     = "apigateway.amazonaws.com"
}
