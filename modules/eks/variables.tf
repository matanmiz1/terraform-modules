variable "account_id" {}

variable "additional_admin_roles" {
  description = "List of additional roles to assign as admin"
  type        = map(string)
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "cluster_name" {}
variable "cluster_version" {
  type    = string
  default = "1.30"
}

variable "enable_karpenter" {
  type    = bool
  default = true
}

variable "vpc_id" {}
variable "private_subnets" {}

variable "custom_oidc_thumbprint" {
  description = "Determines whether to use the static thumbprint which generated without any proxy"
  type        = list(string)
  default     = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
}

variable "custom_oidc_thumbprint_netskope" {
  description = "Determines whether to use the static thumbprint which generated through Netskope connection"
  type        = list(string)
  default     = ["59291054db5b338227c05330b614dbf72054218a"]
}

locals {
  alb_controller_service_account_name = "aws-load-balancer-controller"
  vpc_cni_version = {
    "1.22" = "v1.11.4-eksbuild.1",
    "1.25" = "v1.12.2-eksbuild.1"
    "1.28" = "v1.15.1-eksbuild.1"
    "1.30" = "v1.18.5-eksbuild.1"
  }

  ebs_csi_version = {
    "1.30" = "v1.36.0-eksbuild.1"
  }

  workers_policies = ["AmazonEKSWorkerNodePolicy", "AmazonEKS_CNI_Policy", "AmazonEC2ContainerRegistryReadOnly", "CloudWatchAgentServerPolicy", "AmazonSSMManagedInstanceCore"]
}
