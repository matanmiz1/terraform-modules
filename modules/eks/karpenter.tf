module "karpenter" {
  count = var.enable_karpenter == true ? 1 : 0

  source  = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "~> 20.35.0"

  cluster_name = module.eks.cluster_name

  enable_v1_permissions           = true
  enable_pod_identity             = false
  enable_irsa                     = true
  irsa_oidc_provider_arn          = module.eks.oidc_provider_arn
  irsa_namespace_service_accounts = ["kube-system:karpenter"]

  create_node_iam_role = false
  create_access_entry  = false
  node_iam_role_arn    = aws_iam_role.workers.arn

  iam_policy_use_name_prefix = false
  iam_policy_name            = "KarpenterControllerPolicy-${var.cluster_name}"

  iam_role_use_name_prefix = false
  iam_role_name            = "KarpenterControllerRole-${var.cluster_name}"

  rule_name_prefix = "kptr-${replace(var.cluster_name, "-eks", "")}-"

  # Managed in other Code
  create_instance_profile = false
}
