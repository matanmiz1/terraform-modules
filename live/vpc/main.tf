module "vpc" {
  source = "../../modules/vpc2"

  aws_region = var.aws_region

  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
}
