# Output the secret access key for the IAM user
output "secret_access_key" {
  value       = module.iam.secret_access_key
  description = "Secret Access Key"
  sensitive   = true
}
