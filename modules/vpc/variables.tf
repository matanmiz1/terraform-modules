variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_region_short" {
  type = string
}

variable "cluster_name" {}

variable "environment" {
  default = "test"
}

variable "azs" {}
variable "private_subnets_cidr" {}
variable "public_subnets_cidr" {}

variable "vpc_cidr" {}
variable "vpc_name" {}
