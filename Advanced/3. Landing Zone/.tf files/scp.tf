# Create an SCP to prevent DEV and PROD accounts from operating outside eu-south-2:
resource "aws_organizations_policy" "restrict_regions" {
  name        = "RestrictRegions"
  description = "Restrict AWS usage to eu-south-2"
  type        = "SERVICE_CONTROL_POLICY"
  content = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "DenyOutsideApprovedRegion"
        Effect = "Deny"

        NotAction = [
          "iam:*",
          "organizations:*",
          "route53:*",
          "cloudfront:*",
          "support:*",
          "budgets:*"
        ]

        Resource = "*"

        Condition = {
          StringNotEquals = {
            "aws:RequestedRegion" = "eu-south-2"
          }
        }
    }]
  })
}

# Attach the SCP to the DEV and PROD environments:
resource "aws_organizations_policy_attachment" "dev" {
  policy_id = aws_organizations_policy.restrict_regions.id
  target_id = aws_organizations_organizational_unit.Developer.id
}


resource "aws_organizations_policy_attachment" "prod" {
  policy_id = aws_organizations_policy.restrict_regions.id
  target_id = aws_organizations_organizational_unit.Production.id
}

# AWS Organizations Protect CloudTrail policy + attachment:
resource "aws_organizations_policy" "protect_cloudtrail" {
  name        = "ProtectCloudTrail"
  description = "Prevents disabling or modifying CloudTrail"
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Sid    = "DenyCloudTrailChanges"
      Effect = "Deny"

      Action = [
        "cloudtrail:StopLogging",
        "cloudtrail:DeleteTrail",
        "cloudtrail:UpdateTrail",
      ]

      Resource = "*"
    }]
  })
}

resource "aws_organizations_policy_attachment" "protect_cloudtrail" {
  policy_id = aws_organizations_policy.protect_cloudtrail.id
  target_id = aws_organizations_organization.main.roots[0].id
}

# AWS Organizations
# AWS Organizations Protect AWS Config policy + attachment:
resource "aws_organizations_policy" "protect_aws_config" {
  name        = "ProtectAWSConfig"
  description = "Prevents disabling or modifying AWS Config"
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Sid    = "DenyConfigChanges"
      Effect = "Deny"

      Action = [
        "config:StopConfigurationRecorder",
        "config:DeleteConfigurationRecorder",
        "config:DeleteDeliveryChannel"
      ]

      Resource = "*"
    }]
  })
}

resource "aws_organizations_policy_attachment" "protect_aws_config" {
  policy_id = aws_organizations_policy.protect_aws_config.id
  target_id = aws_organizations_organization.main.roots[0].id
}

# Member accounts should not be able to modify the organization structure or leave the organization + policy attachment:
resource "aws_organizations_policy" "protect_organization" {
  name        = "ProtectOrganization"
  description = "Prevents member accounts from modifying AWS Organizations"
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Sid    = "DenyOrganizationChanges"
      Effect = "Deny"

      Action = [
        "organizations:LeaveOrganization",
        "organizations:MoveAccount",
        "organizations:RemoveAccountFromOrganization"
      ]

      Resource = "*"
    }]
  })
}

resource "aws_organizations_policy_attachment" "protect_organization" {
  policy_id = aws_organizations_policy.protect_organization.id
  target_id = aws_organizations_organization.main.roots[0].id
}