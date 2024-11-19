module "vpc" {
  source = "../../modules/vpc_new"

  aws_region = var.aws_region

  kubernetes_cluster_name = var.cluster_name

  private_subnets_availability_zones = var.private_subnets_availability_zones
  private_subnets_cidrs              = var.private_subnets_cidrs
  public_subnets_availability_zones  = var.public_subnets_availability_zones
  public_subnets_cidrs               = var.public_subnets_cidrs

  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
}

module "eks_cluster" {
  source = "../../modules/eks"

  account_id = data.aws_caller_identity.current.account_id
  aws_region = var.aws_region
  
  cluster_iam_role_name = var.cluster_iam_role_name
  cluster_name          = var.cluster_name
  cluster_version       = var.cluster_version

  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  additional_admin_roles = {
    "PowerUser" = "aws-reserved/sso.amazonaws.com/AWSReservedSSO_PowerUserAccess_d5079ac01278f0a3"
  }
}
