terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.97.0"
    }
  }

  # backend "s3" {
  #   bucket = "<bucket>"
  #   key    = "eks.tfstate"
  #   region = "us-east-1"
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      "Terraform"   = true
      "Environment" = var.environment
      "Owner"       = "Miz"
    }
  }
}