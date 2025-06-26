variable "cloudtrail_bucket" {
  type        = string
  description = "S3 Bucket name to store cloudtrail logs"
}

variable "cloudtrail_bucket_arn" {
  type        = string
  description = "Cloudtrail S3 bucket ARN which store cloudtrail logs"
}


variable "log_group_arn" {
  type        = string
  description = "Cloudwatch log group ARN"
}

variable "cloudwatch_role_arn" {
  description = "ARN for the cloudtrail-to-cloudtrail role"
}

variable "tags" {
  type        = map(string)
  description = "Tags for resources to track cost"
  default = {
    "Project" = "PoC"
  }
}
