module "iam" {
  source                   = "./modules/iam"
  cloudwatch_log_group_arn = module.cloudwatch.log_group_arn
  depends_on               = [module.cloudwatch]
}

module "s3" {
  source = "./modules/s3"
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
}

module "cloudtrail" {
  source                = "./modules/cloudtrail"
  cloudtrail_bucket     = module.s3.cloudtrail_bucket
  cloudtrail_bucket_arn = module.s3.cloudtrail_bucket_arn
  log_group_arn         = module.cloudwatch.log_group_arn
  cloudwatch_role_arn   = module.iam.cloudtrail_role_arn
  depends_on            = [module.cloudwatch, module.s3, module.iam]
}

module "lambda" {
  source               = "./modules/lambda"
  lambda_exec_role_arn = module.iam.lambda_exec_role_arn
}

module "eventbridge" {
  source                 = "./modules/eventbridge"
  lambda_name            = module.lambda.lambda_name
  lambda_arn             = module.lambda.lambda_arn
  eventbridge_source_arn = module.lambda.lambda_arn
}
