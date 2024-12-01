variable "availability_zones" {
  type = list(string)
}

variable "aws_region" {
  type = string
}

variable "client_vpn_subnet_cidr" {
  type = string
}

variable "database_subnets" {
  type = list(string)
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "private_subnets" {
  type = list(string)
}

variable "private_subnets_tags" {
  type    = map(string)
  default = {}
}

variable "public_subnets" {
  type = list(string)
}

variable "public_subnets_tags" {
  type    = map(string)
  default = {}
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}
