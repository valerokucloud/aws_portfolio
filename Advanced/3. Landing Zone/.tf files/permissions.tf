# Create a Permission Set for the CloudEngineers group + attachment:
resource "aws_ssoadmin_permission_set" "cloud_engineer" {
  instance_arn = local.instance_arn
  name         = "CloudEngineer"
  description  = "Permissions for AWS Cloud Engineers"
}

resource "aws_ssoadmin_managed_policy_attachment" "cloud_engineer_poweruser" {
  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.cloud_engineer.arn

  managed_policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

# Attach the Permission Set and the "CloudEngineer" group to the DEV account:
resource "aws_ssoadmin_account_assignment" "cloud_engineers_dev" {
  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.cloud_engineer.arn

  principal_id   = aws_identitystore_group.cloud-engineers.group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.developer.id
  target_type = "AWS_ACCOUNT"

  depends_on = [
    aws_account_region.developer_spain
  ]
}