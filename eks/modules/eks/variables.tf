variable "account_id" {}

variable "admin_accounts" {
  type = list(string)
}

variable "admin_users" {
  type = list(string)
}

variable "admin_roles" {
  type = list(string)
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "cluster_iam_role_name" {}
variable "cluster_name" {}
variable "cluster_version" {}

variable "vpc_id" {}
variable "private_subnets" {}

locals {
  admin_users = [
    for admin_user in var.admin_users :
    {
      userarn  = "arn:aws:iam::${var.account_id}:user/${admin_user}"
      username = admin_user
      groups   = ["system:masters"]
    }
  ]

  admin_roles = [
    for admin_role in var.admin_roles :
    {
      rolearn  = "arn:aws:iam::${var.account_id}:role/${admin_role}"
      username = "admins_sso"
      groups   = ["system:masters"]
    }
  ]

  alb_controller_service_account_name = "aws-load-balancer-controller"
  vpc_cni_version = { 
     "1.22" = "v1.11.4-eksbuild.1",
     "1.25" = "v1.12.2-eksbuild.1"
  }
}
