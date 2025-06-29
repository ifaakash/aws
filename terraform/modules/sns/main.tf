resource "aws_sns_topic" "email_via_lambda" {
  name         = "trigger_email_from_lambda"
  display_name = "Resource Budget email"
  tags         = var.tags
}

resource "aws_sns_topic_subscription" "email_via_lambda_subscription" {
  topic_arn = aws_sns_topic.email_via_lambda.arn
  endpoint  = "aakashc.mac@gmail.com"
  protocol  = "email"
}
