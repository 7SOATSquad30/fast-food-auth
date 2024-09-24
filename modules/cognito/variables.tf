variable "user_pool_name" {
  description = "Cognito User Pool Name"
  type        = string
  default     = "fastfood-user-pool"
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
  description = "Authenticated Role ARN"
  type        = string
}

variable "unauthenticated_role_arn" {
  description = "Unauthenticated Role ARN"
  type        = string
}
