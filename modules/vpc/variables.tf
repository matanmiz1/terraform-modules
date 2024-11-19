variable "aws_region" {
  type = string
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "private_subnets_availability_zones" {
  type    = list(string)
  default = []
}

variable "private_subnets_cidrs" {
  type    = list(string)
  default = []
}

variable "private_subnets_tags" {
  type    = map(string)
  default = {}
}

variable "public_subnets_availability_zones" {
  type    = list(string)
  default = []
}

variable "public_subnets_cidrs" {
  type    = list(string)
  default = []
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
