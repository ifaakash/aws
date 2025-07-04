variable "filename" {
  type        = string
  description = "Filename for AWS lambda"
  default     = "app.zip"
}


variable "lambda_exec_role_arn" {
  type        = string
  description = "IAM Role ARN for creating logs in cloudwatch"
}

variable "sns_topic_arn" {
  type        = string
  description = "ARN for the SNS Topic"
}

variable "tags" {
  type        = map(string)
  description = "Tags for resources to track cost"
  default = {
    "Project" = "PoC"
  }
}
