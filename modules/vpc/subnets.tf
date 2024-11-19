resource "aws_subnet" "public" {
  count = length(var.public_subnets_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnets_cidrs[count.index]
  availability_zone = local.public_subnets_availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = "${var.vpc_name}-public${count.index}-${local.public_subnets_availability_zones[count.index]}"
    },
    local.public_subnets_kubernetes_tags
  )
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets_cidrs[count.index]
  availability_zone = local.private_subnets_availability_zones[count.index]

  tags = merge(
    {
      Name = "${var.vpc_name}-private${count.index}-${local.private_subnets_availability_zones[count.index]}"
    },
    local.private_subnets_kubernetes_tags,
    local.private_subnets_karpenter_tags
  )
}
