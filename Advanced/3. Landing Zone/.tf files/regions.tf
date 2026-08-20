resource "aws_account_region" "developer_spain" {
  account_id  = aws_organizations_account.developer.id
  region_name = "eu-south-2"
  enabled     = true
}