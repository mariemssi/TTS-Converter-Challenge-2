resource "aws_apigatewayv2_api" "api_gateway" {
  name          = "http-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "test" {
  api_id      = aws_apigatewayv2_api.api_gateway.id
  name        = "test"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway_log_group.arn
    format          = jsonencode({ "requestId" : "$context.requestId", "ip" : "$context.identity.sourceIp", "requestTime" : "$context.requestTime", "httpMethod" : "$context.httpMethod", "routeKey" : "$context.routeKey", "status" : "$context.status", "protocol" : "$context.protocol", "responseLength" : "$context.responseLength" })
  }
}

resource "aws_cloudwatch_log_group" "api_gateway_log_group" {
  name              = "/aws/apigateway/APIGatewayLogs"
  retention_in_days = 30
}
