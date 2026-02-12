variable "IAM_roles" {
  type        = map(string)
  description = "IAM roles to create"
}

variable "LambdaExecBasicRole" {
  type        = string
  description = "ARN of existing policy in AWS"
}

variable "role_policy_map" {
  type = map(list(string))
}

variable "aws_region" {
  type    = string
  default = "eu-south-2"
}
