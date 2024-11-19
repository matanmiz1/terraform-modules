variable "aws_region" {
  type = string
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "private_subnets_availability_zones" {
  type    = list(string)
  default = []
}

variable "private_subnets_cidrs" {
  type    = list(string)
  default = []
}

variable "public_subnets_availability_zones" {
  type    = list(string)
  default = []
}

variable "public_subnets_cidrs" {
  type    = list(string)
  default = []
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "enable_kubernetes" {
  type    = bool
  default = true
}

variable "kubernetes_cluster_name" {
  type    = string
  default = ""
}

variable "enable_karpenter" {
  type    = bool
  default = true
}

locals {
  private_subnets_availability_zones = [for i in var.private_subnets_availability_zones : "${var.aws_region}${i}"]
  public_subnets_availability_zones  = [for i in var.public_subnets_availability_zones : "${var.aws_region}${i}"]

  public_subnets_kubernetes_tags = var.enable_kubernetes ? {
    "kubernetes.io/cluster/${var.kubernetes_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                               = "1"
  } : {}
  private_subnets_kubernetes_tags = var.enable_kubernetes ? {
    "kubernetes.io/cluster/${var.kubernetes_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"                      = "1"
  } : {}
  private_subnets_karpenter_tags = var.enable_karpenter ? {
    "karpenter.sh/discovery" = var.kubernetes_cluster_name
  } : {}
}
