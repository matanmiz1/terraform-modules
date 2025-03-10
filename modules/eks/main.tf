module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.34.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      addon_version = local.coredns_version[var.cluster_version]
    }
    kube-proxy = {}
    vpc-cni = {
      addon_version = local.vpc_cni_version[var.cluster_version]
    }
  }

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    disk_size      = 30
    instance_types = ["m6i.large", "m5.large", "m5n.large"]
  }

  eks_managed_node_groups = {
    blue = {
      min_size     = 2
      max_size     = 5
      desired_size = 2

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"

      create_iam_role             = false
      iam_role_arn                = aws_iam_role.workers.arn
      create_iam_instance_profile = false
      create_security_group       = false
    }
  }

  node_security_group_tags = { "karpenter.sh/discovery" = var.cluster_name }

  # Don't change after deployment: https://github.com/terraform-aws-modules/terraform-aws-eks/issues/2007
  iam_role_name                          = "${var.cluster_name}EKSClusterRole"
  iam_role_use_name_prefix               = false
  cluster_security_group_name            = "${var.cluster_name}-cluster_security_group_name" # Additional security group
  cluster_security_group_use_name_prefix = false
  node_security_group_name               = "${var.cluster_name}-node_security_group_name"
  node_security_group_use_name_prefix    = false

  /*
  Extend cluster security group rules
  Adding rules to "Additional security groups" (not primary)
  This security group is not attached to any EC2
  */
  cluster_security_group_additional_rules = {
    ingress_nodes_ephemeral_ports_tcp = {
      description                = "Nodes on ephemeral ports"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "ingress"
      source_node_security_group = true
    }
  }

  /*
  Extend node-to-node security group rules
  Adding rules to node_security_group
  This security group is attached to the (workers) managed node groups EC2s
  */
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
  }

  enable_irsa = true

  # Cluster access entry
  # To add the current caller identity as an administrator / 
  # Add IAM access entry of the role running the terraform to be added with Admin permissions
  enable_cluster_creator_admin_permissions = true

  access_entries = {
    for k, v in var.additional_admin_roles : k => {
      principal_arn = "arn:aws:iam::${var.account_id}:role/${v}"
      type          = "STANDARD"

      policy_associations = {
        example = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  # Deal with netskope
  include_oidc_root_ca_thumbprint = false
  custom_oidc_thumbprints         = concat(var.custom_oidc_thumbprint, var.custom_oidc_thumbprint_netskope)

  tags = {}
}

resource "null_resource" "kubeconfig" {
  triggers = {
    account_id   = var.account_id
    aws_region   = var.aws_region
    cluster_name = var.cluster_name
  }

  # TODO: update context name
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${self.triggers.cluster_name} --region ${self.triggers.aws_region}"
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOF
      kubectl config unset contexts.arn:aws:eks:${self.triggers.aws_region}:${self.triggers.account_id}:cluster/${self.triggers.cluster_name}
      kubectl config unset clusters.arn:aws:eks:${self.triggers.aws_region}:${self.triggers.account_id}:cluster/${self.triggers.cluster_name}
      kubectl config unset users.arn:aws:eks:${self.triggers.aws_region}:${self.triggers.account_id}:cluster/${self.triggers.cluster_name}
    EOF
  }

  depends_on = [module.eks]
}
