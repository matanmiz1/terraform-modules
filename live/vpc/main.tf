module "vpc" {
  source = "../../modules/vpc"

  aws_region = var.aws_region

  private_subnets_availability_zones = slice(data.aws_availability_zones.available.names, 0, var.private_subnets_availability_zones)
  private_subnets_cidrs              = var.private_subnets_cidrs
  public_subnets_availability_zones  = slice(data.aws_availability_zones.available.names, 0, var.public_subnets_availability_zones)
  public_subnets_cidrs               = var.public_subnets_cidrs

  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
}
