aws_region       = "eu-west-1"
aws_region_short = "ie"

cluster_name          = "ie-test-eks"
cluster_iam_role_name = "EKSClusterTFRole"
cluster_version       = "1.30"
environment           = "test"

private_subnets_availability_zones = ["a", "b"]
private_subnets_cidrs              = ["10.0.0.0/20", "10.0.16.0/20"]
public_subnets_availability_zones  = ["a", "b"]
public_subnets_cidrs               = ["10.0.32.0/20", "10.0.64.0/20"]

vpc_cidr = "10.0.0.0/16"
vpc_name = "vpc-MATAN"