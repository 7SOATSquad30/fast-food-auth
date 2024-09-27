# Lambda function ARN
output "lambda_function_arn" {
  description = "ARN da função Lambda"
  value       = aws_lambda_function.lambda_function.arn
}
