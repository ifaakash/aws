resource "aws_cloudwatch_log_group" "cloudtrail_logs" {
  name              = "/aws/cloudtrail/logs"
  retention_in_days = 7
  tags              = var.tags
}
