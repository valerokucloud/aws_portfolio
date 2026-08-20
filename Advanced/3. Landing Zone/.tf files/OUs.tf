# OUs creation. ALL are inside "roots[0]"
resource "aws_organizations_organizational_unit" "Security" {
  name      = "Sec"
  parent_id = aws_organizations_organization.main.roots[0].id
}

resource "aws_organizations_organizational_unit" "Developer" {
  name      = "Dev"
  parent_id = aws_organizations_organization.main.roots[0].id
}

resource "aws_organizations_organizational_unit" "Production" {
  name      = "Prod"
  parent_id = aws_organizations_organization.main.roots[0].id
}