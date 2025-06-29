resource "aws_s3_bucket" "s3" {
  bucket = "nonroot-cloudtrail-logs"
  tags   = var.tags
}
