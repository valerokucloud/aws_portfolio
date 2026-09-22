variable "project_name" {
  type    = string
  default = "aws-operations"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "alert_email" {
  description = "Email address for AWS Ops alerts"
  type = string
}