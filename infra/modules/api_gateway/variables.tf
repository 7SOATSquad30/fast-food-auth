# API Gateway name
variable "api_name" {
  description = "API Gateway name"
  type        = string
  default     = "fastfood-api"
}

# API Gateway description
variable "api_description" {
  description = "API Gateway description"
  type        = string
  default     = "API Gateway for FastFood authentication"
}

# API Gateway part path
variable "path_part" {
  description = "Path part for the API Gateway resource"
  type        = string
  default     = "auth"
}

# Lambda function invoke ARN
variable "lambda_function_invoke_arn" {
  description = "Lambda function Invoke ARN"
  type        = string
}
