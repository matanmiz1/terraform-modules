resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = var.vpc_name
  }
}
