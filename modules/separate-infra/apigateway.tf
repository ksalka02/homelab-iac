# locals {
#   dev_port_number = var.port_dev
#   prd_port_number = var.port_prod
# }


# VPC link ################################################################################################
resource "aws_api_gateway_vpc_link" "vpc_link" {
  name        = "${var.app_name}-vpclink"
  target_arns = [aws_lb.api_lb.arn]
}


# api key ################################################################################################
resource "aws_api_gateway_api_key" "mykey" {
  name = "${var.app_name}-key"
}

resource "aws_api_gateway_usage_plan_key" "main" {
  key_id        = aws_api_gateway_api_key.mykey.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.example.id
}


# API ################################################################################################
resource "aws_api_gateway_rest_api" "players_api" {
  body = templatefile("${path.root}/swagger-files/${var.api_json_file}",
    {
      "vpc_link" = aws_api_gateway_vpc_link.vpc_link.id
      "LB_DNS"   = aws_lb.api_lb.dns_name


      # "lb_dns"   = "http://${aws_lb.api_lb.dns_name}:5000/players"
  })

  name = "${var.app_name}_api"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

}


# deployment ################################################################################################
resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.players_api.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.players_api.body)) #to trigger redeploy whenever there is a change in json file
  }                                                                            # MAYBE USE sha512 INSTEAD?

  lifecycle {
    create_before_destroy = true
  }
}


# STAGES ################################################################################################
resource "aws_api_gateway_stage" "development" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.players_api.id
  stage_name    = "development"

  variables = {
    PORT = var.port_dev
    # VPC_LINK_URI_1 = "${aws_lb.api_lb.dns_name}:${var.port_dev}${var.path.path_1}"
    # VPC_LINK_URI_2 = "${aws_lb.api_lb.dns_name}:${var.port_dev}${var.path.path_2}"
  }
}

resource "aws_api_gateway_stage" "production" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.players_api.id
  stage_name    = "production"

  variables = {
    PORT = var.port_prod
  }
}


# usage plan ################################################################################################
resource "aws_api_gateway_usage_plan" "example" {
  name         = "${var.app_name}-usage-plan"
  description  = "my description"
  product_code = "MY-CODE"

  api_stages {
    api_id = aws_api_gateway_rest_api.players_api.id
    stage  = aws_api_gateway_stage.development.stage_name
  }

  api_stages {
    api_id = aws_api_gateway_rest_api.players_api.id
    stage  = aws_api_gateway_stage.production.stage_name
  }

  quota_settings {
    limit  = var.quota_settings.limit
    offset = var.quota_settings.offset
    period = var.quota_settings.period
  }

  throttle_settings {
    burst_limit = var.throttle_settings.burst_limit
    rate_limit  = var.throttle_settings.rate_limit
  }
}
