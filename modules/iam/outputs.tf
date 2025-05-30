output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn
}

output "transfer_role_arn" {
  value = aws_iam_role.transfer_family_role.arn
}
