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

variable "vpc_cidr" {}
variable "vpc_name" {}

locals {
  private_subnets   = [cidrsubnet(var.vpc_cidr, 3, 1), cidrsubnet(var.vpc_cidr, 3, 2), cidrsubnet(var.vpc_cidr, 3, 3)]    # X.X.32.0/19  X.X.64.0/19  X.X.96.0/19
  public_subnets    = [cidrsubnet(var.vpc_cidr, 8, 5), cidrsubnet(var.vpc_cidr, 8, 6), cidrsubnet(var.vpc_cidr, 8, 7)]    # X.X.5.0/24   X.X.6.0/24   X.X.7.0/24
  database_subnets  = [cidrsubnet(var.vpc_cidr, 8, 15), cidrsubnet(var.vpc_cidr, 8, 16), cidrsubnet(var.vpc_cidr, 8, 17)] # X.X.15.0/24  X.X.16.0/24  X.X.17.0/24
  client_vpn_subnet = "10.0.0.0/24"

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
