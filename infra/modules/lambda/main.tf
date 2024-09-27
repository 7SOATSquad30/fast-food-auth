data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Create a IAM for Lambda
resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Generates a file from the file directory.
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/index.mjs"
  output_path = "${path.module}/lambda_function_payload.zip"
}

# Create a Lambda function
resource "aws_lambda_function" "lambda_function" {
  filename         = data.archive_file.lambda.output_path
  function_name    = var.lambda_name
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "index.handler"
  runtime          = var.lambda_runtime

  source_code_hash = data.archive_file.lambda.output_base64sha256

  environment {
    variables = {
      lambda_function = var.lambda_name
    }
  }
}

# Create a Lambda permission
resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "apigateway.amazonaws.com"
}
