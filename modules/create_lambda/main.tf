data "aws_ssm_parameter" "vars" {
  count = "${length(var.env_vars)}"
  name  = "${var.parameter_store_path}/${var.env_vars[count.index]}"
}

resource "aws_lambda_function" "aws_lambda_function" {
  function_name = var.function_name
  description   = var.description

  filename  = var.function_source
  role      = var.role_arn

  source_code_hash = filebase64sha256(var.function_source)

  runtime     = var.runtime
  handler     = var.handler
  memory_size = var.memory_size
  timeout     = var.timeout

  vpc_config {
    subnet_ids         = flatten([var.subnet_ids])
    security_group_ids = flatten([var.security_group_ids])
  }

  environment {
    #variables = zipmap(var.env_vars, data.aws_ssm_parameter.vars.*.value)
    variables  = {
      foo      = "bar"
    }
  }
}

resource "aws_lambda_permission" "cloudwatch_trigger" {
  count         = var.add_cloudwatch_trigger ? 1 : 0
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.aws_lambda_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = var.cloudwatch_event_source_arn
}

resource "aws_lambda_permission" "apigw_trigger" {
  count         = var.add_apigw_trigger ? 1 : 0
  statement_id  = "AllowExecutionFromAPIGW"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.aws_lambda_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = var.apigw_event_source_arn
}
