provider "aws" {
  region = var.aws_region
}

module "iam" {
  source = "./modules/iam"
}

module "s3" {
  source = "./modules/s3"
}

module "lambda" {
  source = "./modules/lambda"
  s3_bucket = module.s3.bucket_name
  lambda_role_arn = module.iam.lambda_role_arn
}

module "apigateway" {
  source = "./modules/apigateway"
  lambda_function_name = module.lambda.function_name
}

module "transfer_family" {
  source = "./modules/transfer_family"
  s3_bucket = module.s3.bucket_name
  transfer_role_arn = module.iam.transfer_role_arn
}
