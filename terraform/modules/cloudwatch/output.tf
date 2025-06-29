output "log_group_arn" {
  value = "${aws_cloudwatch_log_group.cloudtrail_logs.arn}:*"
}
