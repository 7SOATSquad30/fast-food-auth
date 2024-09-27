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
