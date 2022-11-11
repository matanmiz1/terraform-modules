# VPC module is used for managing the resources in the primary az
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = [for az in var.azs : "${var.aws_region}${az}"]
  private_subnets = var.private_subnets_cidr
  public_subnets  = var.public_subnets_cidr

  enable_dns_hostnames = true

  # Single NAT Gateway
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  tags = {}
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }
}
