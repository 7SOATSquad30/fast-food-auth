# Store the Lambda ID in the Parameter Store
resource "aws_ssm_parameter" "lambda_id" {
  name  = "/lambda/lambda_id"
  type  = "String"
  value = aws_lambda_function.lambda_function.id
}

# Store the Lambda ARN in the Parameter Store
resource "aws_ssm_parameter" "lambda_arn" {
  name  = "/lambda/lambda_arn"
  type  = "String"
  value = aws_lambda_function.lambda_function.arn
}

# Store the Lambda Invoke ARN in the Parameter Store
resource "aws_ssm_parameter" "lambda_invoke_arn" {
  name  = "/lambda/lambda_invoke_arn"
  type  = "String"
  value = aws_lambda_function.lambda_function.invoke_arn
}
