terraform {
  required_version = ">= 1.6"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.47"
    }

  }
}

provider "aws" {
  region = var.aws_region
}

provider "aws" {
  alias = "virginia"
  region = "us-east-1"
}