variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_region_short" {
  type = string
}

variable "cluster_iam_role_name" {}
variable "cluster_name" {}
variable "cluster_version" {}

variable "environment" {
  default = "test"
}

variable "private_subnets_availability_zones" {}
variable "private_subnets_cidrs" {}
variable "public_subnets_availability_zones" {}
variable "public_subnets_cidrs" {}

variable "vpc_cidr" {}
variable "vpc_name" {}

locals {
  public_subnets_kubernetes_tags = {
    "kubernetes.io/role/elb" = "1"
  }
  private_subnets_kubernetes_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
  private_subnets_karpenter_tags = {
    "karpenter.sh/discovery" = var.cluster_name
  }
  private_subnets_tags = merge(local.private_subnets_kubernetes_tags, local.private_subnets_karpenter_tags)
  public_subnets_tags  = local.public_subnets_kubernetes_tags
}