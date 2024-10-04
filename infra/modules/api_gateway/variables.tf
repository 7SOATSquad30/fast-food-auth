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

# Parameter store Security Group
variable "parameter_store_sg" {
  description = "Parameter store Security Group"
  type        = string
  default     = "default_security_group_id"
}

# Issuer URL endpoint
variable "issuer_url_endpoint" {
  description = "Issuer URL endpoint"
  type        = string
  default     = "https://cognito-idp.us-east-1.amazonaws.com/"
}

# Issuer URL User Pool ID
variable "issuer_url_user_pool" {
  description = "Issuer URL User Pool ID"
  type        = string
}

# Audience
variable "audience" {
  description = "Audience"
  type        = string
}
