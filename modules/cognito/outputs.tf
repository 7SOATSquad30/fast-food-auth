output "user_pool_id" {
  description = "ID do User Pool"
  value       = aws_cognito_user_pool.user_pool.id
}

output "client_id" {
  description = "ID do Client"
  value       = aws_cognito_user_pool_client.client.id
}

output "identity_pool_id" {
  description = "ID do Identity Pool"
  value       = aws_cognito_identity_pool.identity_pool.id
}
