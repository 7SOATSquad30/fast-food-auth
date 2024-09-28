# Lambda function ID
output "lambda_function_id" {
  description = "Lambda function ID"
  value       = aws_lambda_function.lambda_function.id
}

# Lambda function ARN
output "lambda_function_arn" {
  description = "Lambda function ARN"
  value       = aws_lambda_function.lambda_function.arn
}

# Lambda function invoke ARN
output "lambda_function_invoke_arn" {
  description = "Lambda function invoke ARN"
  value       = aws_lambda_function.lambda_function.invoke_arn
}
