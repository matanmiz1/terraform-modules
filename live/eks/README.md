# EKS
Deploying EKS cluster,using managed node group.
Installing EBS controller using addon.
AWS Load Balancer Controller was migrated to ArgoCD.
Karpenter was migrated to ArgoCD.

Tested on versions:  
aws ~ **5.75.1**
kubernetes ~ **2.33.0**
eks ~ **20.30.1**
karpenter ~ **20.30.1**

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
