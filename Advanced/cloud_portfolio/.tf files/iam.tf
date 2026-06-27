# Lambda trust relationship creation:
  resource "aws_iam_role" "sts_role" {
    for_each = local.lambda_roles
    name = each.key
    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
        Effect = "Allow"
        Principal = {
            Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
        }
    ]
    })
}

# DDB policy creation:
  resource "aws_iam_policy" "ddb" {
    for_each = local.DB_inline_policy
    name   = each.key
    policy = jsonencode(each.value)
}


# role policy attachment for all lambdas:
  resource "aws_iam_role_policy_attachment" "ddb" {
  for_each = {
    for item in flatten([
      for role, policies in local.lambda_roles : [
        for policy in policies : {
          key    = "${role}-${policy}"
          role   = role
          policy = policy
        }
      ]
    ]) :
    item.key => item
  }

  role = aws_iam_role.sts_role[each.value.role].name
  policy_arn = aws_iam_policy.ddb[each.value.policy].arn
}

# Role policy attachment for CloudWatch Logs 4 Lambdas:
resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
  for_each = aws_iam_role.sts_role
  role = each.value.name
  policy_arn = local.iam_managed_policies.cloudwatch_logs

}

