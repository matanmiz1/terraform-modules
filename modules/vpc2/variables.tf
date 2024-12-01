variable "aws_region" {
  type = string
}

# variable "client_vpn_subnet_cidr" {
#   type    = string
#   default = "10.0.0.0/24"
# }

variable "database_subnets" {
  type = list(object({
    availability_zone = string
    cidr              = string
    tags              = map(string)
  }))  
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "private_subnets" {
  type = list(object({
    availability_zone = string
    cidr              = string
    tags              = map(string)
  }))
}

variable "public_subnets" {
  type = list(object({
    availability_zone = string
    cidr              = string
    tags              = map(string)
  }))
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}
