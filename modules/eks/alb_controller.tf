# https://github.com/kubernetes-sigs/aws-load-balancer-controller/blob/main/docs/install/iam_policy.json
resource "aws_iam_policy" "alb_controller" {
  name        = "AWSLoadBalancerControllerIAMPolicy-${var.cluster_name}"
  path        = "/"
  description = "Policy for AWS Load Balancer Controller add-on"
  policy      = file("${path.module}/resources/alb-controller-policy.json")
}

data "aws_iam_policy_document" "alb_controller_assume" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [module.eks.oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:sub"
      values = [
        "system:serviceaccount:kube-system:${local.alb_controller_service_account_name}"
      ]
    }
  }
}

resource "aws_iam_role" "alb_controller" {
  name               = "AmazonEKSLoadBalancerControllerRole-${var.cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.alb_controller_assume.json
}

resource "aws_iam_role_policy_attachment" "alb_controller" {
  role       = aws_iam_role.alb_controller.name
  policy_arn = aws_iam_policy.alb_controller.arn
}

# resource "helm_release" "alb_controller" {
#   name       = "aws-load-balancer-controller"
#   chart      = "aws-load-balancer-controller"
#   repository = "https://aws.github.io/eks-charts"
#   namespace  = "kube-system"
#   version    = "1.10.0"
#   set {
#     name  = "clusterName"
#     value = var.cluster_name
#   }
#   set {
#     name  = "serviceAccount.create"
#     value = true
#   }
#   set {
#     name  = "serviceAccount.name"
#     value = local.alb_controller_service_account_name
#   }
#   set{
#     name = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
#     value = "arn:aws:iam::883241448326:role/AmazonEKSLoadBalancerControllerRole-ie-test-eks"
#   }
#   depends_on = [module.eks]
# }