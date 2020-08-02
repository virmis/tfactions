variable "aws_region" {
  description = "The AWS region to deploy to (e.g. eu-west-1)"
  default     = "Lambda deployed with Terraform..."
}

variable "description" {
  default = ""
}

variable "function_name" {
  default  = ""
}

variable "function_source" {}

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "security_group_ids" {
  type    = list(string)
  default = []
}

variable "role_arn" {
  type     = string
  default  = ""
}

variable "handler" {
  default = "index.handler"
}

variable "runtime" {
  default = "nodejs12.x"
}

variable "memory_size" {
  default = 128
}

variable "timeout" {
  default = 10
}

variable "cloudwatch_event_source_arn" {
  default = ""
}

variable "add_cloudwatch_trigger" {
  description = "Variable indicating whether a CloudWatch trigger should be added to lambda"
  default     = false
}

variable "apigw_event_source_arn" {
  default = ""
}

variable "add_apigw_trigger" {
  description = "Variable indicating whether a APIGateway trigger should be added to lambda"
  default     = false
}

variable "parameter_store_path" {
  description = "Path to environment value key in parameter store"
}

variable "env_vars" {
  type    = list
  default = []
}
