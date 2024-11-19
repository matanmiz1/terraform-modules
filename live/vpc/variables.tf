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

variable "kubernetes_cluster_name"{}

variable "private_subnets_availability_zones" {}
variable "private_subnets_cidrs" {}
variable "public_subnets_availability_zones" {}
variable "public_subnets_cidrs" {}

variable "vpc_cidr" {}
variable "vpc_name" {}
