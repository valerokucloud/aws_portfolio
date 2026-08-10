# ECR repository for Argus:
resource "aws_ecr_repository" "argus" {
  name                 = "argus"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}