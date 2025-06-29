output "sns_topic_arn" {
  value = aws_sns_topic.email_via_lambda.arn
}
