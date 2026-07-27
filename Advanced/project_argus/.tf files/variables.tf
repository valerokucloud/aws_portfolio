variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

# Bucket variable name:
variable "bucket_name" {
  description = "Bucket name"
  type        = string
}

# Personal email for SNS:
variable "alert_email" {
  description = "Email used for Argus alerts"
  type = string
}