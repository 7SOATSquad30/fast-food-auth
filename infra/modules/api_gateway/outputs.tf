# API Gateway ID
output "api_gateway_id" {
  description = "The ID of the HTTP API."
  value       = aws_apigatewayv2_api.api.id
}

# API Gateway Endpoint
output "api_gateway_endpoint" {
  description = "The endpoint URL for the HTTP API."
  value       = aws_apigatewayv2_api.api.api_endpoint
}

# API Gateway Stage Name
output "api_gateway_stage_name" {
  description = "The name of the stage for the HTTP API."
  value       = aws_apigatewayv2_stage.default_stage.name
}

# VPC Link Id
output "vpc_link_id" {
  description = "The ID of the VPC link for the HTTP API."
  value       = aws_apigatewayv2_vpc_link.vpc_link.id
}

# Authorizer ID
output "authorizer_id" {
  description = "The ID of the JWT authorizer."
  value       = aws_apigatewayv2_authorizer.jwt_auth.id
}

# Route ID
output "route_id" {
  description = "The ID of the route configured for the HTTP API."
  value       = aws_apigatewayv2_route.proxy_route.id
}

# Integration ID
output "integration_id" {
  description = "The ID of the integration configured for the HTTP API."
  value       = aws_apigatewayv2_integration.private_integration.id
}
