resource "aws_lambda_function" "lambda" {
  function_name    = "nonroot-lambda"
  role             = var.lambda_exec_role_arn
  description      = "Lambda function to handle eventbridge triggers"
  filename         = var.filename # <zip_file_name>
  runtime          = "python3.12"
  package_type     = "Zip"
  publish          = true
  handler          = "app.lambda_handler"
  source_code_hash = filebase64sha256(var.filename)
  tags             = var.tags
}
