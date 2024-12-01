variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "aws_region_short" {
  type    = string
  default = "ie"
}

variable "environment" {
  default = "test"
}

locals {
  vpc_id = "vpc-XXXX"
  private_subnets = ["subnet-XXXX", "subnet-XXXX", "subnet-XXXX"]
}
