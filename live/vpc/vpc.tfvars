aws_region       = "eu-west-1"
aws_region_short = "ie"

private_subnets = [
  {
    availability_zone = "a"
    cidr              = "10.0.0.0/20"
    tags              = {}
  },
  {
    availability_zone = "b"
    cidr              = "10.0.16.0/20"
    tags              = {}
  }
]
public_subnets = [
  {
    availability_zone = "a"
    cidr              = "10.0.32.0/20"
    tags              = {}
  },
  {
    availability_zone = "b"
    cidr              = "10.0.48.0/20"
    tags              = {}
  }
]

vpc_cidr = "10.0.0.0/16"
vpc_name = "vpc-MATAN"
