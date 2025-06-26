variable "lambda_arn" {
  type        = string
  description = "ARN of the lambda which act as target"
}

variable "lambda_name" {
  type        = string
  description = "Name of target lambda function"
}

variable "eventbridge_source_arn" {
  type        = string
  description = "ARN of the eventbridge source which trigger this lambda"
}

variable "tags" {
  type        = map(string)
  description = "Tags for resources to track cost"
  default = {
    "Project" = "PoC"
  }
}
