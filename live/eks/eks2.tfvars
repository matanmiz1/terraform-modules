aws_region       = "eu-west-1"
aws_region_short = "ie"

cluster_name = "ie-test-eks"

environment = "test"

private_subnets = [
  {
    availability_zone = "a"
    cidr              = "10.0.32.0/19" # 8192
    tags              = {}
  },
  {
    availability_zone = "b"
    cidr              = "10.0.64.0/19"
    tags              = {}
  },
  {
    availability_zone = "c"
    cidr              = "10.0.96.0/19"
    tags              = {}
  }
]
public_subnets = [
  {
    availability_zone = "a"
    cidr              = "10.0.5.0/24" # 256
    tags              = {}
  },
  {
    availability_zone = "b"
    cidr              = "10.0.6.0/24"
    tags              = {}
  },
  {
    availability_zone = "c"
    cidr              = "10.0.7.0/24"
    tags              = {}
  }
]
database_subnets = [
  {
    availability_zone = "a"
    cidr              = "10.0.15.0/24" # 256
    tags              = {}
  },
  {
    availability_zone = "b"
    cidr              = "10.0.16.0/24"
    tags              = {}
  },
  {
    availability_zone = "c"
    cidr              = "10.0.17.0/24"
    tags              = {}
  }
]
# client_vpn_subnet_cidr = "10.0.0.0/24"

vpc_cidr = "10.0.0.0/16"
vpc_name = "vpc-MATAN"
