# EKS
Deploying EKS cluster,using managed node group.  
Installing AWS Load Balancer Controller using helm chart.  

Tested on versions:  
aws ~ **4.62.0**  
kubernetes ~ **2.19.0**  
vpc ~ **4.0.1**  
eks ~ **19.12.0**  
  
list of resources created:  
  
data.aws_caller_identity.current  
--- ALB Controller ---  
module.eks_cluster.data.aws_iam_policy_document.alb_controller_assume
module.eks_cluster.aws_iam_policy.alb_controller
module.eks_cluster.aws_iam_role.alb_controller
module.eks_cluster.aws_iam_role_policy_attachment.alb_controller
module.eks_cluster.helm_release.alb_controller
module.eks_cluster.kubernetes_service_account.alb_controller
--- ALB Controller ---  
  
--- EKS ---  
module.eks_cluster.null_resource.kubeconfig  
module.eks_cluster.module.eks.data.aws_caller_identity.current
module.eks_cluster.module.eks.data.aws_eks_addon_version.this["coredns"]
module.eks_cluster.module.eks.data.aws_eks_addon_version.this["kube-proxy"]
module.eks_cluster.module.eks.data.aws_eks_addon_version.this["vpc-cni"]
module.eks_cluster.module.eks.data.aws_iam_policy_document.assume_role_policy[0]
module.eks_cluster.module.eks.data.aws_iam_session_context.current
module.eks_cluster.module.eks.data.aws_partition.current
module.eks_cluster.module.eks.data.tls_certificate.this[0]
module.eks_cluster.module.eks.aws_cloudwatch_log_group.this[0]
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

--- VPC ---  
module.vpc.module.vpc.aws_default_network_acl.this[0]
module.vpc.module.vpc.aws_default_route_table.default[0]
module.vpc.module.vpc.aws_default_security_group.this[0]
module.vpc.module.vpc.aws_eip.nat[0]
module.vpc.module.vpc.aws_internet_gateway.this[0]
module.vpc.module.vpc.aws_nat_gateway.this[0]
module.vpc.module.vpc.aws_route.private_nat_gateway[0]
module.vpc.module.vpc.aws_route.public_internet_gateway[0]
module.vpc.module.vpc.aws_route_table.private[0]
module.vpc.module.vpc.aws_route_table.public[0]
module.vpc.module.vpc.aws_route_table_association.private[0]
module.vpc.module.vpc.aws_route_table_association.private[1]
module.vpc.module.vpc.aws_route_table_association.public[0]
module.vpc.module.vpc.aws_route_table_association.public[1]
module.vpc.module.vpc.aws_subnet.private[0]
module.vpc.module.vpc.aws_subnet.private[1]
module.vpc.module.vpc.aws_subnet.public[0]
module.vpc.module.vpc.aws_subnet.public[1]
module.vpc.module.vpc.aws_vpc.this[0]
--- VPC ---  

--- Node Groups ---  
module.eks_cluster.module.eks.module.eks_managed_node_group["blue"].data.aws_caller_identity.current
module.eks_cluster.module.eks.module.eks_managed_node_group["blue"].data.aws_iam_policy_document.assume_role_policy[0]
module.eks_cluster.module.eks.module.eks_managed_node_group["blue"].data.aws_partition.current
module.eks_cluster.module.eks.module.eks_managed_node_group["blue"].aws_eks_node_group.this[0]
module.eks_cluster.module.eks.module.eks_managed_node_group["blue"].aws_iam_role.this[0]
module.eks_cluster.module.eks.module.eks_managed_node_group["blue"].aws_iam_role_policy_attachment.this["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"]
module.eks_cluster.module.eks.module.eks_managed_node_group["blue"].aws_iam_role_policy_attachment.this["arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"]
module.eks_cluster.module.eks.module.eks_managed_node_group["blue"].aws_iam_role_policy_attachment.this["arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"]
module.eks_cluster.module.eks.module.eks_managed_node_group["blue"].aws_launch_template.this[0]
--- Node Groups ---  

--- KMS ---  
module.eks_cluster.module.eks.module.kms.data.aws_caller_identity.current
module.eks_cluster.module.eks.module.kms.data.aws_iam_policy_document.this[0]
module.eks_cluster.module.eks.module.kms.data.aws_partition.current
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