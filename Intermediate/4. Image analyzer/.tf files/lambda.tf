# Data source for Lambda files:
  data "archive_file" "lambda_zip" {
    for_each = local.lambdas

    type        = "zip"
    source_file = "${path.module}/lambda/${replace(each.key, "-", "_")}.py"
    output_path = "${path.module}/lambda/${each.key}.zip"
  }

# Lambda(2) function creation (for-each):
  resource "aws_lambda_function" "this" {
    for_each = local.lambdas
      function_name = each.value.function_name
      handler = "${each.key}.lambda_handler"
      runtime = "python3.10"
      role = aws_iam_role.lambda_role[each.value.role].arn

      filename = data.archive_file.lambda_zip[each.key].output_path
      source_code_hash = data.archive_file.lambda_zip[each.key].output_base64sha256

    # BUCKET name env.variable
      environment {
        variables = {
          BUCKET = aws_s3_bucket.tf_image_rek.bucket
    }
  }
}


