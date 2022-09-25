Tested on versions:
vpc ~ 3.14.4
eks ~ 18.29.0

list of resources created:
data.aws_caller_identity.current
--- EKS ---
module.eks_cluster.null_resource.kubeconfig
module.eks_cluster.module.eks.data.aws_caller_identity.current
module.eks_cluster.module.eks.data.aws_iam_policy_document.assume_role_policy[0]
module.eks_cluster.module.eks.data.aws_partition.current
module.eks_cluster.module.eks.data.tls_certificate.this[0]
module.eks_cluster.module.eks.aws_cloudwatch_log_group.this[0]
module.eks_cluster.module.eks.aws_eks_addon.this["coredns"]
module.eks_cluster.module.eks.aws_eks_addon.this["kube-proxy"]
module.eks_cluster.module.eks.aws_eks_addon.this["vpc-cni"]
module.eks_cluster.module.eks.aws_eks_cluster.this[0]
module.eks_cluster.module.eks.aws_iam_openid_connect_provider.oidc_provider[0]
module.eks_cluster.module.eks.aws_iam_role.this[0]
module.eks_cluster.module.eks.aws_iam_role_policy_attachment.this["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"]
module.eks_cluster.module.eks.aws_iam_role_policy_attachment.this["arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"]
module.eks_cluster.module.eks.aws_security_group.cluster[0]
module.eks_cluster.module.eks.aws_security_group.node[0]
module.eks_cluster.module.eks.aws_security_group_rule.cluster["egress_nodes_443"]
module.eks_cluster.module.eks.aws_security_group_rule.cluster["egress_nodes_ephemeral_ports_tcp"]
module.eks_cluster.module.eks.aws_security_group_rule.cluster["egress_nodes_kubelet"]
module.eks_cluster.module.eks.aws_security_group_rule.cluster["ingress_nodes_443"]
module.eks_cluster.module.eks.aws_security_group_rule.node["egress_all"]
module.eks_cluster.module.eks.aws_security_group_rule.node["egress_cluster_443"]
module.eks_cluster.module.eks.aws_security_group_rule.node["egress_https"]
module.eks_cluster.module.eks.aws_security_group_rule.node["egress_ntp_tcp"]
module.eks_cluster.module.eks.aws_security_group_rule.node["egress_ntp_udp"]
module.eks_cluster.module.eks.aws_security_group_rule.node["egress_self_coredns_tcp"]
module.eks_cluster.module.eks.aws_security_group_rule.node["egress_self_coredns_udp"]
module.eks_cluster.module.eks.aws_security_group_rule.node["ingress_cluster_443"]
module.eks_cluster.module.eks.aws_security_group_rule.node["ingress_cluster_kubelet"]
module.eks_cluster.module.eks.aws_security_group_rule.node["ingress_self_all"]
module.eks_cluster.module.eks.aws_security_group_rule.node["ingress_self_coredns_tcp"]
module.eks_cluster.module.eks.aws_security_group_rule.node["ingress_self_coredns_udp"]
module.eks_cluster.module.eks.kubernetes_config_map_v1_data.aws_auth[0]
--- EKS ---
--- VPC ---
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
module.eks_cluster.module.eks.module.eks_managed_node_group["blue"].aws_security_group.this[0]
module.eks_cluster.module.eks.module.eks_managed_node_group["green"].data.aws_caller_identity.current
module.eks_cluster.module.eks.module.eks_managed_node_group["green"].data.aws_iam_policy_document.assume_role_policy[0]
module.eks_cluster.module.eks.module.eks_managed_node_group["green"].data.aws_partition.current
module.eks_cluster.module.eks.module.eks_managed_node_group["green"].aws_eks_node_group.this[0]
module.eks_cluster.module.eks.module.eks_managed_node_group["green"].aws_iam_role.this[0]
module.eks_cluster.module.eks.module.eks_managed_node_group["green"].aws_iam_role_policy_attachment.this["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"]
module.eks_cluster.module.eks.module.eks_managed_node_group["green"].aws_iam_role_policy_attachment.this["arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"]
module.eks_cluster.module.eks.module.eks_managed_node_group["green"].aws_iam_role_policy_attachment.this["arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"]
module.eks_cluster.module.eks.module.eks_managed_node_group["green"].aws_launch_template.this[0]
module.eks_cluster.module.eks.module.eks_managed_node_group["green"].aws_security_group.this[0]
--- Node Groups ---
--- KMS ---
module.eks_cluster.module.eks.module.kms.data.aws_caller_identity.current
module.eks_cluster.module.eks.module.kms.data.aws_partition.current
--- KMS ---
