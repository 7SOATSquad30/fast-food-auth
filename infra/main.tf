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

# Connect the API Gateway module
module "api_gateway" {
  source                     = "./modules/api_gateway"
  api_name                   = var.api_name
  api_description            = var.api_description
  path_part                  = var.path_part
  lambda_function_invoke_arn = module.lambda.lambda_function_invoke_arn

  depends_on = [module.lambda]
}

# Create a Lambda permission
resource "aws_lambda_permission" "api_gateway_invoke_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.lambda_function_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.api_gateway.api_execution_arn}/"

  depends_on = [module.api_gateway]
}
