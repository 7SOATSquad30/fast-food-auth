variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "user_pool_name" {
  description = "Cognito User Pool Name"
  type        = string
}

variable "client_name" {
  description = "Cognito client name"
  type        = string
  default     = "fastfood-client"
}

variable "callback_urls" {
  description = "Allowed URLs for Cognito callbacks"
  type        = list(string)
  default     = ["https://example.com/callback"]
}

variable "identity_pool_name" {
  description = "Identity Pool Name"
  type        = string
  default     = "fastfood-identity-pool"
}

variable "authenticated_role_arn" {
  description = "Authtenticated Role Arn"
  type        = string
}

variable "unauthenticated_role_arn" {
  description = "Unauthtenticated Role Arn"
  type        = string
}