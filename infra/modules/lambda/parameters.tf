# Store the Lambda ARN in the Parameter Store
resource "aws_ssm_parameter" "lambda_arn" {
  name  = "/lambda/lambda_arn"
  type  = "String"
  value = aws_lambda_function.lambda_function.arn
}
