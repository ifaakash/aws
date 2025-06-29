variable "cloudwatch_log_group_arn" {
  type        = string
  description = "Log group arn in cloudwatch to put log and create steam"
}

variable "tags" {
  type        = map(string)
  description = "Tags for resources to track cost"
  default = {
    "Project" = "PoC"
  }
}
