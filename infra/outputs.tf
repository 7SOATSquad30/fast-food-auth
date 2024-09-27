output "cognito_user_pool_id" {
  description = "ID do Cognito User Pool"
  value       = module.cognito.user_pool_id
}

output "cognito_client_id" {
  description = "ID do cliente Cognito"
  value       = module.cognito.client_id
}

output "cognito_identity_pool_id" {
  description = "ID do Cognito Identity Pool"
  value       = module.cognito.identity_pool_id
}

# Lambda function ARN
output "lambda_function_arn" {
  description = "ARN da função Lambda"
  value       = module.lambda.lambda_function_arn
}