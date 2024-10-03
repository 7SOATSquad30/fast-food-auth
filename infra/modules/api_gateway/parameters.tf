# Store the HTTP API ID in the Parameter Store
resource "aws_ssm_parameter" "api" {
  name  = "/api_gateway/api"
  type  = "String"
  value = aws_apigatewayv2_api.api.id
}

# Store the VPC Link ID in the Parameter Store
resource "aws_ssm_parameter" "vpc_link" {
  name  = "/api_gateway/vpc_link"
  type  = "String"
  value = aws_apigatewayv2_vpc_link.vpc_link.id
}

# Store the Authorizer ID in the Parameter Store
resource "aws_ssm_parameter" "authorizer" {
  name  = "/api_gateway/authorizer"
  type  = "String"
  value = aws_apigatewayv2_authorizer.jwt_auth.id
}

# Store the Integration ID in the Parameter Store
resource "aws_ssm_parameter" "integration" {
  name  = "/api_gateway/integration"
  type  = "String"
  value = aws_apigatewayv2_integration.private_integration.id
}
