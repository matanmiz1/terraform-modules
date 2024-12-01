resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.this.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = var.private_subnets[count.index]

  tags = merge({
    Name = "${var.vpc_name}-private-${var.availability_zones[count.index]}"
    },
    var.private_subnets_tags
  )
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id            = aws_vpc.this.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = var.public_subnets[count.index]

  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = "${var.vpc_name}-public-${var.availability_zones[count.index]}"
    },
    var.public_subnets_tags
  )
}

resource "aws_subnet" "database" {
  count = length(var.database_subnets)

  vpc_id            = aws_vpc.this.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = var.database_subnets[count.index]

  tags = {
    Name = "${var.vpc_name}-database-${var.availability_zones[count.index]}"
  }
}

resource "aws_subnet" "client_vpn" {
  vpc_id            = aws_vpc.this.id
  availability_zone = var.availability_zones[0]
  cidr_block        = var.client_vpn_subnet_cidr

  tags = {
    Name = "${var.vpc_name}-client-vpn-${var.availability_zones[0]}"
  }
}
