# Output the secret access key for the IAM user
output "secret_access_key" {
  value       = aws_iam_access_key.access_key.secret
  description = "Secret Access Key"
}

output "cloudtrail_role_arn" {
  value = aws_iam_role.cloudtrail_role.arn
}
