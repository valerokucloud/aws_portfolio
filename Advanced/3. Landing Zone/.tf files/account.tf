# OU account creation. Each one must have a different email address
# + parent_id (OU) association:

resource "aws_organizations_account" "security" {
  name      = "Security"
  email     = "sec@example.com"
  parent_id = aws_organizations_organizational_unit.Security.id


  close_on_deletion = false
}

resource "aws_organizations_account" "developer" {
  name      = "Developer"
  email     = "dev@example.com"
  parent_id = aws_organizations_organizational_unit.Developer.id

  close_on_deletion = false
}

resource "aws_organizations_account" "prod" {
  name      = "Production"
  email     = "prod@example.com"
  parent_id = aws_organizations_organizational_unit.Production.id

  close_on_deletion = false
}
