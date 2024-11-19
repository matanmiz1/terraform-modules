resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.this.default_route_table_id

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  tags = {
    Name = "${var.vpc_name}-default"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  dynamic "route" {
    for_each = length(var.public_subnets_cidrs) > 0 ? [1] : []
    content {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.this.id
    }
  }

  tags = {
    Name = "${var.vpc_name}-public-${var.aws_region}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  dynamic "route" {
    for_each = length(var.public_subnets_cidrs) > 0 && length(var.private_subnets_cidrs) > 0 ? [1] : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.this[0].id
    }
  }

  tags = {
    Name = "${var.vpc_name}-private-${var.aws_region}"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets_cidrs)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets_cidrs)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
