module "vpc" {
  source = "../../modules/vpc"

  aws_region = var.aws_region

  availability_zones     = slice(data.aws_availability_zones.available.names, 0, 3)
  private_subnets        = local.private_subnets
  public_subnets         = local.public_subnets
  database_subnets       = local.database_subnets
  client_vpn_subnet_cidr = local.client_vpn_subnet

  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name

  private_subnets_tags = local.private_subnets_tags
  public_subnets_tags  = local.public_subnets_tags
}

module "eks" {
  source = "../../modules/eks"

  account_id = data.aws_caller_identity.current.account_id
  aws_region = var.aws_region

  cluster_name = var.cluster_name

  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  additional_admin_roles = {
    "PowerUser" = "aws-reserved/sso.amazonaws.com/AWSReservedSSO_PowerUserAccess_d5079ac01278f0a3"
  }
}
