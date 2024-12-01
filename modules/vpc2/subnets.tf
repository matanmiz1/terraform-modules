resource "aws_subnet" "private" {
  for_each = { for idx, subnet in var.private_subnets : subnet.cidr => merge(subnet, { idx = idx })}

  vpc_id            = aws_vpc.this.id
  availability_zone = each.value.availability_zone
  cidr_block        = each.key

  tags = merge(
    {
      Name = "${var.vpc_name}-private${each.value.idx}-${each.value.availability_zone}"
    },
    each.value.tags
  )
}

resource "aws_subnet" "public" {
  for_each = { for idx, subnet in var.public_subnets : subnet.cidr => merge(subnet, { idx = idx })}

  vpc_id            = aws_vpc.this.id
  availability_zone = each.value.availability_zone
  cidr_block        = each.key

  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = "${var.vpc_name}-public${each.value.idx}-${each.value.availability_zone}"
    },
    each.value.tags
  )
}

resource "aws_subnet" "database" {
  for_each = { for idx, subnet in var.database_subnets : subnet.cidr => merge(subnet, { idx = idx })}

  vpc_id            = aws_vpc.this.id
  availability_zone = each.value.availability_zone
  cidr_block        = each.key

  tags = merge(
    {
      Name = "${var.vpc_name}-database${each.value.idx}-${each.value.availability_zone}"
    },
    each.value.tags
  )
}

# resource "aws_subnet" "client_vpn" {
#   vpc_id            = aws_vpc.this.id
#   availability_zone = var.private_subnets[0].availability_zone
#   cidr_block        = var.client_vpn_subnet_cidr

#   tags = {
#     Name = "${var.vpc_name}-client-vpn-${var.private_subnets[0].availability_zone}"
#   }
# }
