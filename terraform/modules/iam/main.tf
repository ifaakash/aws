# Create an IAM user
resource "aws_iam_user" "read_only_user" {
  name          = "read_only_user"
  path          = "/read_only/"
  force_destroy = true # Destroy this user even if it has non-terraform managed resources
  tags          = var.tags
}

# Get the Access Key for IAM user
resource "aws_iam_access_key" "access_key" {
  user = aws_iam_user.read_only_user.name
}

locals {
  iam_user_name = aws_iam_user.read_only_user.name
}

# Create an IAM User
resource "aws_iam_role" "read_only_user_iam_role" {
  name = "read_only_user_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = aws_iam_user.read_only_user.arn
      }
      Action = "sts:AssumeRole"
    }]
  })
  tags = var.tags
}

# # Attach the assume role policy to the IAM user
# resource "aws_iam_user_policy" "attach_assume_role" {
#   name = "attach_assume_role_to_read_only_user"
#   user = aws_iam_user.read_only_user.name
#   policy = jsonencode({
#     Version : "2012-10-17"
#     Statement : [{
#       Action : "sts:AssumeRole"
#       Effect : "Allow"
#       Resource : aws_iam_role.read_only_user_iam_role.arn
#     }]
#   })
# }

# Create IAM Policy
resource "aws_iam_policy" "list_s3_policy" {
  name        = "list_s3_buckets"
  description = "Allow ListAllBuckets permission to read_only user"
  policy = jsonencode({
    Version : "2012-10-17"
    Statement : [{
      Action : "s3:ListAllMyBuckets"
      Effect : "Allow"
      Resource : "*"
    }]
  })
  tags = var.tags
}

# Attach Policy to IAM User
resource "aws_iam_user_policy_attachment" "name" {
  policy_arn = aws_iam_policy.list_s3_policy.arn
  user       = aws_iam_user.read_only_user.name
}


# Attach Policy to IAM Role
resource "aws_iam_role_policy_attachment" "attach_list_s3" {
  role       = aws_iam_role.read_only_user_iam_role.name
  policy_arn = aws_iam_policy.list_s3_policy.arn
}

# Create IAM role for cloudtrail to assume role
resource "aws_iam_role" "cloudtrail_role" {
  name = "cloudtrail-to-cloudwatch"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "cloudtrail.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}

# Create IAM policy to allow PutLogEvent in cloudwatch log group
resource "aws_iam_role_policy" "cloudtrail_policy" {
  name = "CloudTrailPolicy"
  role = aws_iam_role.cloudtrail_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "${var.cloudwatch_log_group_arn}:*"
      }
    ]
  })
}

# IAM Role for AWS Lambda to assume
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Required permission for AWS lambda to perform action on other resources
resource "aws_iam_policy" "permissions" {
  name        = "lambda_permissions"
  description = "Required IAM permission for AWS Lambda Execution"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          "Resource" : "*"
        }
      ]
    }
  )
}


resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.permissions.arn
}
