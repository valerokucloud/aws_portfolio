# Policy creation + association:
resource "aws_iam_policy" "ddb" {
  for_each = local.IAM_inline_policies
  name     = each.key
  policy   = jsonencode(each.value)
}

# Attaching inline policies:
resource "aws_iam_role_policy_attachment" "ddb" {
  for_each = {
    for item in flatten([
      for role, policies in local.lambda_roles_final : [
        for policy in policies :
        contains(keys(local.IAM_inline_policies), policy) ? {
          key    = "${role}-${policy}"
          role   = role
          policy = policy
        } : null
      ]
    ]) : item.key => item
    if item != null
  }

  role       = aws_iam_role.lambda[each.value.role].name
  policy_arn = aws_iam_policy.ddb[each.value.policy].arn
}

# Attaching CloudWatch managed policy:
resource "aws_iam_role_policy_attachment" "cloudwatch" {
  for_each = local.lambda_roles

  role       = aws_iam_role.lambda[each.key].name
  policy_arn = local.IAM_managed_policies.cloudwatch_logs
}