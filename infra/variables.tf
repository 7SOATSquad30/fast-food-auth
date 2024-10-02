# Cognito variables
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# Cognito User Pool name
variable "user_pool_name" {
  description = "Cognito User Pool Name"
  type        = string
  default     = "fastfood-user-pool"
}

# Cognito User Pool Domain Prefix
variable "user_pool_domain_prefix" {
  description = "Cognito domain prefix"
  type        = string
  default     = "fastfood-domain"
}

# Cognito Cliente name
variable "client_name" {
  description = "Cognito client name"
  type        = string
  default     = "fastfood-client"
}

# Cognito Callback URLs
variable "callback_urls" {
  description = "Allowed URLs for Cognito callbacks"
  type        = list(string)
  default     = ["https://example.com/callback"]
}

# Cognito Identity Pool name
variable "identity_pool_name" {
  description = "Identity Pool Name"
  type        = string
  default     = "fastfood-identity-pool"
}

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
