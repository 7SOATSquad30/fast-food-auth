# Cognito User Pool ID
output "cognito_user_pool_id" {
  description = "ID do Cognito User Pool"
  value       = module.cognito.user_pool_id
}

# Cognito Client ID
output "cognito_client_id" {
  description = "ID do cliente Cognito"
  value       = module.cognito.client_id
}

# Cognito Identity Pool ID
output "cognito_identity_pool_id" {
  description = "ID do Cognito Identity Pool"
  value       = module.cognito.identity_pool_id
}

# Lambda function ARN
output "lambda_function_arn" {
  description = "Lambda function ARN"
  value       = module.lambda.lambda_function_arn
}