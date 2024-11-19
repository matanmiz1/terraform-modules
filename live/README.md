# EKS
Deploying EKS cluster,using managed node group.
Installing Karpenter using helm chart.
Installing EBS controller using addon.
AWS Load Balancer Controller was migrated to ArgoCD.

Tested on versions:  
aws ~ **5.61.0**
kubernetes ~ **2.33.0**
eks ~ **20.23.0**
karpenter ~ **20.17.2**
  
list of resources created:

data.aws_caller_identity.current
--- EBS Controller ---
module.eks_cluster.data.aws_iam_policy.AmazonEBSCSIDriverPolicy
module.eks_cluster.data.aws_iam_policy_document.ebs_assume
module.eks_cluster.aws_eks_addon.ebs
module.eks_cluster.aws_iam_role.ebs
--- EBS Controller ---

--- ALB Controller ---
module.eks_cluster.data.aws_iam_policy_document.alb_controller_assume
module.eks_cluster.aws_iam_policy.alb_controller
module.eks_cluster.aws_iam_role.alb_controller
module.eks_cluster.aws_iam_role_policy_attachment.alb_controller
--- ALB Controller ---
  
--- EKS ---
module.eks_cluster.aws_iam_instance_profile.workers
module.eks_cluster.aws_iam_role.workers
module.eks_cluster.aws_iam_role_policy_attachment.workers["AmazonEC2ContainerRegistryReadOnly"]
module.eks_cluster.aws_iam_role_policy_attachment.workers["AmazonEKSWorkerNodePolicy"]
module.eks_cluster.aws_iam_role_policy_attachment.workers["AmazonEKS_CNI_Policy"]
module.eks_cluster.aws_iam_role_policy_attachment.workers["AmazonSSMManagedInstanceCore"]
module.eks_cluster.aws_iam_role_policy_attachment.workers["CloudWatchAgentServerPolicy"]
module.eks_cluster.null_resource.kubeconfig
module.eks_cluster.module.eks.data.aws_caller_identity.current
module.eks_cluster.module.eks.data.aws_eks_addon_version.this["coredns"]
module.eks_cluster.module.eks.data.aws_eks_addon_version.this["kube-proxy"]
module.eks_cluster.module.eks.data.aws_eks_addon_version.this["vpc-cni"]
module.eks_cluster.module.eks.data.aws_iam_policy_document.assume_role_policy[0]
module.eks_cluster.module.eks.data.aws_iam_session_context.current
module.eks_cluster.module.eks.data.aws_partition.current
module.eks_cluster.module.eks.aws_cloudwatch_log_group.this[0]
module.eks_cluster.module.eks.aws_eks_access_entry.this["PowerUser"]
module.eks_cluster.module.eks.aws_eks_access_entry.this["cluster_creator"]
module.eks_cluster.module.eks.aws_eks_access_policy_association.this["PowerUser_example"]
module.eks_cluster.module.eks.aws_eks_access_policy_association.this["cluster_creator_admin"]
module.eks_cluster.module.eks.aws_eks_addon.this["coredns"]
module.eks_cluster.module.eks.aws_eks_addon.this["kube-proxy"]
module.eks_cluster.module.eks.aws_eks_addon.this["vpc-cni"]
module.eks_cluster.module.eks.aws_eks_cluster.this[0]
module.eks_cluster.module.eks.aws_iam_openid_connect_provider.oidc_provider[0]
module.eks_cluster.module.eks.aws_iam_policy.cluster_encryption[0]
module.eks_cluster.module.eks.aws_iam_role.this[0]
module.eks_cluster.module.eks.aws_iam_role_policy_attachment.cluster_encryption[0]
module.eks_cluster.module.eks.aws_iam_role_policy_attachment.this["AmazonEKSClusterPolicy"]
module.eks_cluster.module.eks.aws_iam_role_policy_attachment.this["AmazonEKSVPCResourceController"]
module.eks_cluster.module.eks.aws_security_group.cluster[0]
module.eks_cluster.module.eks.aws_security_group.node[0]
module.eks_cluster.module.eks.aws_security_group_rule.cluster["ingress_nodes_443"]
module.eks_cluster.module.eks.aws_security_group_rule.cluster["ingress_nodes_ephemeral_ports_tcp"]
module.eks_cluster.module.eks.aws_security_group_rule.node["egress_all"]
module.eks_cluster.module.eks.aws_security_group_rule.node["ingress_cluster_443"]
module.eks_cluster.module.eks.aws_security_group_rule.node["ingress_cluster_4443_webhook"]
module.eks_cluster.module.eks.aws_security_group_rule.node["ingress_cluster_6443_webhook"]
module.eks_cluster.module.eks.aws_security_group_rule.node["ingress_cluster_8443_webhook"]
module.eks_cluster.module.eks.aws_security_group_rule.node["ingress_cluster_9443_webhook"]
module.eks_cluster.module.eks.aws_security_group_rule.node["ingress_cluster_kubelet"]
module.eks_cluster.module.eks.aws_security_group_rule.node["ingress_nodes_ephemeral"]
module.eks_cluster.module.eks.aws_security_group_rule.node["ingress_self_all"]
module.eks_cluster.module.eks.aws_security_group_rule.node["ingress_self_coredns_tcp"]
module.eks_cluster.module.eks.aws_security_group_rule.node["ingress_self_coredns_udp"]
module.eks_cluster.module.eks.time_sleep.this[0]
--- EKS ---

--- Karpenter ---
module.eks_cluster.helm_release.karpenter
module.eks_cluster.module.karpenter.data.aws_caller_identity.current
module.eks_cluster.module.karpenter.data.aws_iam_policy_document.controller[0]
module.eks_cluster.module.karpenter.data.aws_iam_policy_document.controller_assume_role[0]
module.eks_cluster.module.karpenter.data.aws_iam_policy_document.queue[0]
module.eks_cluster.module.karpenter.data.aws_partition.current
module.eks_cluster.module.karpenter.data.aws_region.current
module.eks_cluster.module.karpenter.aws_cloudwatch_event_rule.this["health_event"]
module.eks_cluster.module.karpenter.aws_cloudwatch_event_rule.this["instance_rebalance"]
module.eks_cluster.module.karpenter.aws_cloudwatch_event_rule.this["instance_state_change"]
module.eks_cluster.module.karpenter.aws_cloudwatch_event_rule.this["spot_interrupt"]
module.eks_cluster.module.karpenter.aws_cloudwatch_event_target.this["health_event"]
module.eks_cluster.module.karpenter.aws_cloudwatch_event_target.this["instance_rebalance"]
module.eks_cluster.module.karpenter.aws_cloudwatch_event_target.this["instance_state_change"]
module.eks_cluster.module.karpenter.aws_cloudwatch_event_target.this["spot_interrupt"]
module.eks_cluster.module.karpenter.aws_iam_policy.controller[0]
module.eks_cluster.module.karpenter.aws_iam_role.controller[0]
module.eks_cluster.module.karpenter.aws_iam_role_policy_attachment.controller[0]
module.eks_cluster.module.karpenter.aws_sqs_queue.this[0]
module.eks_cluster.module.karpenter.aws_sqs_queue_policy.this[0]
--- Karpenter ---

--- VPC ---
module.vpc.aws_default_network_acl.default
module.vpc.aws_default_route_table.default
module.vpc.aws_default_security_group.default
module.vpc.aws_eip.nat[0]
module.vpc.aws_internet_gateway.this
module.vpc.aws_nat_gateway.this[0]
module.vpc.aws_route_table.private
module.vpc.aws_route_table.public
module.vpc.aws_route_table_association.private[0]
module.vpc.aws_route_table_association.private[1]
module.vpc.aws_route_table_association.public[0]
module.vpc.aws_route_table_association.public[1]
module.vpc.aws_subnet.private[0]
module.vpc.aws_subnet.private[1]
module.vpc.aws_subnet.public[0]
module.vpc.aws_subnet.public[1]
module.vpc.aws_vpc.this
--- VPC ---

--- Node Groups ---
module.eks_cluster.module.eks.module.eks_managed_node_group["blue"].data.aws_caller_identity.current
module.eks_cluster.module.eks.module.eks_managed_node_group["blue"].data.aws_partition.current
module.eks_cluster.module.eks.module.eks_managed_node_group["blue"].aws_eks_node_group.this[0]
module.eks_cluster.module.eks.module.eks_managed_node_group["blue"].aws_launch_template.this[0]
module.eks_cluster.module.eks.module.kms.data.aws_caller_identity.current[0]
module.eks_cluster.module.eks.module.kms.data.aws_iam_policy_document.this[0]
module.eks_cluster.module.eks.module.kms.data.aws_partition.current[0]
module.eks_cluster.module.eks.module.kms.aws_kms_alias.this["cluster"]
module.eks_cluster.module.eks.module.kms.aws_kms_key.this[0]
module.eks_cluster.module.eks.module.eks_managed_node_group["blue"].module.user_data.null_resource.validate_cluster_service_cidr
--- Node Groups ---

--- KMS ---
module.eks_cluster.module.eks.module.kms.data.aws_caller_identity.current[0]
module.eks_cluster.module.eks.module.kms.data.aws_iam_policy_document.this[0]
module.eks_cluster.module.eks.module.kms.data.aws_partition.current[0]
module.eks_cluster.module.eks.module.kms.aws_kms_alias.this["cluster"]
module.eks_cluster.module.eks.module.kms.aws_kms_key.this[0]
--- KMS ---

## Known Bugs
1. Deploying the module results in the following error:
```
│ Error: The configmap "aws-auth" does not exist
│ 
│   with module.eks_cluster.module.eks.kubernetes_config_map_v1_data.aws_auth[0],
│   on .terraform/modules/eks_cluster.eks/main.tf line 553, in resource "kubernetes_config_map_v1_data" "aws_auth":
│  553: resource "kubernetes_config_map_v1_data" "aws_auth" {
```

This error is documented problematic in here: https://github.com/terraform-aws-modules/terraform-aws-eks/issues/2009

But this doesn't mean there is an error with the configmap, but concealing other problem which is **error connecting to the cluster**.

* Update the kubeconfig with ```aws eks update-kubeconfig --name <> --region <>```
* Run ```kubectl get pods``` results in error: ```Unable to connect to the server: x509: certificate signed by unknown authority```

In my MacOS, this happens because netskope prevents from using self-signed certificates.
To get around this, run ```kubectl get pods --insecure-skip-tls-verify``` once, than run ```terraform apply``` again.
