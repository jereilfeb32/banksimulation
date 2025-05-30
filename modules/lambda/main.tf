resource "aws_lambda_function" "portfolio_simulator" {
  function_name = "portfolio_simulation_lambda"
  role          = var.lambda_role_arn
  handler       = "main.lambda_handler"
  runtime       = "python3.9"

  filename         = "${path.module}/lambda_payload.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_payload.zip")

  environment {
    variables = {
      BUCKET_NAME = var.s3_bucket
    }
  }
}

resource "null_resource" "zip_lambda" {
  provisioner "local-exec" {
    command = "cd lambda_code && zip -r ../lambda_payload.zip ."
  }
  triggers = {
    always_run = timestamp()
  }
}
