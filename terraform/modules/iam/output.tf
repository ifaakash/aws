# Output the secret access key for the IAM user
output "secret_access_key" {
  value       = aws_iam_access_key.access_key.secret
  description = "Secret Access Key"
}

output "cloudtrail_role_arn" {
  description = "ARN for Cloudtrail IAM role to put logs in log group"
  value       = aws_iam_role.cloudtrail_role.arn
}

output "lambda_exec_role_arn" {
  description = "ARN for the lambda IAM role"
  value       = aws_iam_role.lambda_exec_role.arn
}
