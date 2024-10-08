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

# Stage name
variable "stage_name" {
  description = "Stage name"
  type        = string
  default     = "$default"
}

# VPC link name
variable "vpc_link_name" {
  description = "VPC link name"
  type        = string
  default     = "fastfood-vpc"
}

# Issuer URL endpoint
variable "issuer_url_endpoint" {
  description = "Issuer URL endpoint"
  type        = string
  default     = "https://cognito-idp.us-east-1.amazonaws.com/"
}
