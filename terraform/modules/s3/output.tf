output "cloudtrail_bucket" {
  value = aws_s3_bucket.s3.id
}

output "cloudtrail_bucket_arn" {
  value = aws_s3_bucket.s3.arn
}
