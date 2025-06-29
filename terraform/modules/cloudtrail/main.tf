resource "aws_cloudtrail" "cloudtrail" {
  name                          = "log_account_level_activity"
  s3_bucket_name                = "nonroot-cloudtrail-logs"
  include_global_service_events = true
  enable_logging                = true

  cloud_watch_logs_group_arn = var.log_group_arn
  cloud_watch_logs_role_arn  = var.cloudwatch_role_arn
  tags                       = var.tags

  depends_on = [aws_s3_bucket_policy.cloudtrail_policy]
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket_policy" "cloudtrail_policy" {
  bucket = var.cloudtrail_bucket

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AWSCloudTrailAclCheck",
        Effect    = "Allow",
        Principal = { Service = "cloudtrail.amazonaws.com" },
        Action    = "s3:GetBucketAcl",
        Resource  = var.cloudtrail_bucket_arn
      },
      {
        Sid       = "AWSCloudTrailWrite",
        Effect    = "Allow",
        Principal = { Service = "cloudtrail.amazonaws.com" },
        Action    = "s3:PutObject",
        Resource  = "${var.cloudtrail_bucket_arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}
