resource "aws_organizations_organization" "main" {
  feature_set = "ALL"

  enabled_policy_types = ["SERVICE_CONTROL_POLICY"]
  aws_service_access_principals = [
    "sso.amazonaws.com",
    "account.amazonaws.com",
    "cloudtrail.amazonaws.com"
  ]
}