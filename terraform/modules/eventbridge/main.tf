resource "aws_cloudwatch_event_rule" "trigger_source" {
  name        = "createS3Bucket"
  description = "Trigger Lambda on S3 CreateBucket event"
  # event_bus_name = "createS3Bucket"
  event_pattern = jsonencode({
    "source" : ["aws.s3"],
    "detail-type" : ["AWS API Call via CloudTrail"],
    "detail" : {
      "eventSource" : ["s3.amazonaws.com"],
      "eventName" : ["CreateBucket"]
    }
  })
  tags = var.tags
}

resource "aws_cloudwatch_event_target" "trigger_target" {
  arn  = var.lambda_arn
  rule = aws_cloudwatch_event_rule.trigger_source.name
}


resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "events.amazonaws.com"
  source_arn    = var.eventbridge_source_arn
}
