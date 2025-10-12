# Creating a new group (Administrators):
    resource "aws_iam_group" "Administrators_group" {
      name = "Administrators"
      path = "/Users/" # Optional, basic user/group
    }

# IAM user creation:
    resource "aws_iam_user" "admin_user" {
    name = "admin_user"
    # Path in which to create the user:
        path = "/Users/"
    #  When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices:
        force_destroy = true
    }

# Access key for the user:
    resource "aws_iam_access_key" "AK_user" {
    user = aws_iam_user.admin_user.name
    }

# AdminAccess policy for the user:
    resource "aws_iam_user_policy_attachment" "admin_access_policy" {
    user       = aws_iam_user.admin_user.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
    }

# IAM user group membership:
    resource "aws_iam_user_group_membership" "user_group_memb" {
    user = aws_iam_user.admin_user.name

    groups = [
    aws_iam_group.Administrators_group.name
  ]
}