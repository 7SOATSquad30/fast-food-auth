# Lambda function ARN
output "lambda_function_arn" {
  description = "Lambda function ARN"
  value       = aws_lambda_function.lambda_function.arn
}
