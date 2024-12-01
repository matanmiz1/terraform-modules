variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_region_short" {
  type = string
}

variable "environment" {
  default = "test"
}

variable "private_subnets" {
  type = list(object({
    availability_zone = string
    cidr              = string
    tags              = map(string)
  }))
}

variable "public_subnets" {
  type = list(object({
    availability_zone = string
    cidr              = string
    tags              = map(string)
  }))
}

variable "vpc_cidr" {}
variable "vpc_name" {}

locals {
  private_subnets = [for s in var.private_subnets : {
    availability_zone = "${var.aws_region}${s.availability_zone}"
    cidr              = s.cidr
    tags              = s.tags
  }]
  public_subnets = [for s in var.public_subnets : {
    availability_zone = "${var.aws_region}${s.availability_zone}"
    cidr              = s.cidr
    tags              = s.tags
  }]
}