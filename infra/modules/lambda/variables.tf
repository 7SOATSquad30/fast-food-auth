# Lambda function name
variable "lambda_name" {
  description = "Lambda function name"
  type        = string
  default     = "fastfood-lambda"
}

# Lambda function runtime
variable "lambda_runtime" {
  description = "Lambda function runtime"
  type        = string
  default     = "nodejs20.x"
}
