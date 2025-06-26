output "lambda_name" {
  value = aws_lambda_function.lambda.function_name
}

output "lambda_arn" {
  description = "ARN of the Lambda"
  value       = aws_lambda_function.lambda.arn
}
