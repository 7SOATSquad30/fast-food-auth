# Retrieve VPC ID from AWS Parameter Store
data "aws_ssm_parameter" "vpc_id" {
  name = "/rds/vpc"
}

# Retrieves load_balancer_listener_arn from AWS Parameter Store
data "aws_ssm_parameter" "load_balancer_listener_arn" {
  name = "/elb/listener_arn"
}

# Retrieves subnet_1 from AWS Parameter Store
data "aws_ssm_parameter" "subnet_1" {
  name = "/rds/subnet_1"
}

# Retrieves subnet_2 from AWS Parameter Store
data "aws_ssm_parameter" "subnet_2" {
  name = "/rds/subnet_2"
}

# Retrieves subnet_3 from AWS Parameter Store
data "aws_ssm_parameter" "subnet_3" {
  name = "/rds/subnet_3"
}

# Creates a list of subnet IDs
locals {
  subnet_ids = [
    data.aws_ssm_parameter.subnet_1.value,
    data.aws_ssm_parameter.subnet_2.value,
    data.aws_ssm_parameter.subnet_3.value,
  ]
}

# Retrieve Security Group ID from AWS Parameter Store
data "aws_ssm_parameter" "sg_id" {
  name = var.parameter_store_sg
}

# Create VPC Link for HTTP API
resource "aws_apigatewayv2_vpc_link" "vpc_link" {
  name               = var.vpc_link_name
  subnet_ids         = local.subnet_ids
  security_group_ids = [data.aws_ssm_parameter.sg_id.value]
}

# Create the HTTP API
resource "aws_apigatewayv2_api" "api" {
  name          = var.api_name
  protocol_type = "HTTP"
}

# Configure Stage
resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = var.stage_name
  auto_deploy = true
}

# JWT Authorizer
resource "aws_apigatewayv2_authorizer" "jwt_auth" {
  api_id          = aws_apigatewayv2_api.api.id
  name            = "jwt-auth"
  authorizer_type = "JWT"

  jwt_configuration {
    audience = [var.audience]
    issuer   = "${var.issuer_url_endpoint}${var.issuer_url_user_pool}"
  }

  identity_sources = ["$request.header.Authorization"]
}

# Integration with ALB/NLB
resource "aws_apigatewayv2_integration" "private_integration" {
  api_id = aws_apigatewayv2_api.api.id

  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  integration_uri    = data.aws_ssm_parameter.load_balancer_listener_arn.value # ALB/NLB listener ARN

  connection_type        = "VPC_LINK"
  connection_id          = aws_apigatewayv2_vpc_link.vpc_link.id
  payload_format_version = "1.0"
}

# Route and Method ANY /{proxy+}
resource "aws_apigatewayv2_route" "proxy_route" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "ANY /{proxy+}"

  target = "integrations/${aws_apigatewayv2_integration.private_integration.id}"

  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.jwt_auth.id
}
