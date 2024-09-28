# Store the REST API ID in the Parameter Store
resource "aws_ssm_parameter" "api" {
  name  = "/api_gateway/api"
  type  = "String"
  value = aws_api_gateway_rest_api.api.id
}

# Store the Resource ID in the Parameter Store
resource "aws_ssm_parameter" "resource" {
  name  = "/api_gateway/resource"
  type  = "String"
  value = aws_api_gateway_resource.resource.id
}

# Store the Method ID in the Parameter Store
resource "aws_ssm_parameter" "method" {
  name  = "/api_gateway/method"
  type  = "String"
  value = aws_api_gateway_method.method.id
}

# Store the Integration ID in the Parameter Store
resource "aws_ssm_parameter" "integration" {
  name  = "/api_gateway/integration"
  type  = "String"
  value = aws_api_gateway_integration.integration.id
}

# Store the Deployment ID in the Parameter Store
resource "aws_ssm_parameter" "deployment" {
  name  = "/api_gateway/deployment"
  type  = "String"
  value = aws_api_gateway_deployment.deployment.id
}
