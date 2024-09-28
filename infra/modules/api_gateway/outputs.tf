# API Gateway ID
output "api_gateway_id" {
  description = "API Gateway ID"
  value       = aws_api_gateway_rest_api.api.id
}

# API Gateway URL
output "api_gateway_url" {
  description = "API Gateway URL"
  value       = aws_api_gateway_deployment.deployment.invoke_url
}

# API Gateway execution ARN
output "api_execution_arn" {
  description = "API Gateway execution ARN"
  value       = aws_api_gateway_rest_api.api.execution_arn
}
