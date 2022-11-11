module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.30.3"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      addon_version     = "v1.11.4-eksbuild.1"
      resolve_conflicts = "OVERWRITE"
    }
  }

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    disk_size      = 50
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    blue = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"
    }
  }

  # Don't change after deployment: https://github.com/terraform-aws-modules/terraform-aws-eks/issues/2007
  iam_role_name                          = var.cluster_iam_role_name
  iam_role_use_name_prefix               = false
  cluster_security_group_name            = "cluster_security_group_name" # Additional security group
  cluster_security_group_use_name_prefix = false
  node_security_group_name               = "node_security_group_name"
  node_security_group_use_name_prefix    = false

  /*
  Extend cluster security group rules
  Adding rules to "Additional security groups" (not primary)
  This security group is not attached to any EC2
  */
  cluster_security_group_additional_rules = {
    egress_nodes_ephemeral_ports_tcp = {
      description                = "To node 1025-65535"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "egress"
      source_node_security_group = true
    }
  }


  /*
  Extend node-to-node security group rules
  Adding rules to node_security_group
  This security group is attached to the managed node groups EC2s
  */
  node_security_group_ntp_ipv4_cidr_block = ["169.254.169.123/32"]
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  # aws-auth configmap
  enable_irsa               = true
  manage_aws_auth_configmap = true

  aws_auth_roles    = local.admin_roles
  aws_auth_users    = local.admin_users
  aws_auth_accounts = var.admin_accounts

  tags = {}
}

resource "null_resource" "kubeconfig" {
  triggers = {
    account_id   = var.account_id
    aws_region   = var.aws_region
    cluster_name = var.cluster_name
  }

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
