variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-south-2"
}

variable "budget_email" {
  description = "Email used for AWS Budget notifications"
  type = string
  default = "your-email@example.com"
}