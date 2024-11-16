module "karpenter" {
  source  = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "~> 20.17.2"

  cluster_name = module.eks.cluster_name

  enable_pod_identity    = false
  enable_irsa            = true
  irsa_oidc_provider_arn = module.eks.oidc_provider_arn

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

resource "helm_release" "karpenter" {
  namespace        = "karpenter"
  create_namespace = true

  name       = "karpenter"
  repository = "oci://public.ecr.aws/karpenter"
  chart      = "karpenter"
  version    = "v0.32.10"

  set {
    name  = "settings.aws.clusterName"
    value = module.eks.cluster_name
  }

  set {
    name  = "settings.aws.clusterEndpoint"
    value = module.eks.cluster_endpoint
  }

  set {
    name  = "serviceAccount.name"
    value = module.karpenter.service_account
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.karpenter.iam_role_arn
  }

  set {
    name  = "settings.aws.interruptionQueueName"
    value = module.karpenter.queue_name
  }
}
