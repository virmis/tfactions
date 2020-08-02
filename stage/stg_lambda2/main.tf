module "role" {
  source = "../../modules/create_policy"

  attach_policy_lambda_basic_execution_role = false
}

module "lambda" {
  source  = "../../modules/create_lambda"

  aws_region                  = "eu-central-1"
  function_name               = "stg_lambda2"
  description                 = "Test staging lambda function number 2"
  function_source             = "src/lambda_function_payload.zip"
  role_arn                    = module.role.lambda_role_arn
  timeout                     = 3
  add_cloudwatch_trigger      = false
  parameter_store_path        = "/stage/lambda/ps-test"
  env_vars                    = []
}