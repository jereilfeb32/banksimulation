resource "aws_s3_bucket" "lambda_data" {
  bucket = "wealth-portfolio-data-bucket"
  force_destroy = true
}
