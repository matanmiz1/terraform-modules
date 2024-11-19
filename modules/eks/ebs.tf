data "aws_iam_policy" "AmazonEBSCSIDriverPolicy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

data "aws_iam_policy_document" "ebs_assume" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [module.eks.oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${module.eks.oidc_provider}:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "${module.eks.oidc_provider}:sub"
      values = [
        "system:serviceaccount:kube-system:ebs-csi-controller-sa"
      ]
    }
  }
}

# TODO: managed_policy_arns is deprecated
resource "aws_iam_role" "ebs" {
  name                = "AmazonEKS_EBS_CSI_DriverRole-${var.cluster_name}"
  assume_role_policy  = data.aws_iam_policy_document.ebs_assume.json
  managed_policy_arns = [data.aws_iam_policy.AmazonEBSCSIDriverPolicy.arn]
}

resource "aws_eks_addon" "ebs" {
  cluster_name                = module.eks.cluster_name
  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = local.ebs_csi_version[var.cluster_version]
  resolve_conflicts_on_update = "OVERWRITE"
  service_account_role_arn    = aws_iam_role.ebs.arn

  # https://github.com/kubernetes-sigs/aws-ebs-csi-driver/issues/1163#issuecomment-2271422732
  configuration_values = jsonencode({
    node = {
      volumeAttachLimit = 20
    }
  })
}
