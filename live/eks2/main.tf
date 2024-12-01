module "eks2" {
  source = "../../modules/eks"

  account_id = data.aws_caller_identity.current.account_id
  aws_region = var.aws_region

  cluster_name     = "ie-test-eks2"
  enable_karpenter = false

  vpc_id          = local.vpc_id
  private_subnets = local.private_subnets
  additional_admin_roles = {
    "PowerUser" = "aws-reserved/sso.amazonaws.com/AWSReservedSSO_PowerUserAccess_d5079ac01278f0a3"
  } 
}
