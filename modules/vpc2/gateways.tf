resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# TODO: more than a single nat gateway
resource "aws_nat_gateway" "this" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${var.vpc_name}-nat"
  }

  depends_on = [aws_internet_gateway.this]
}

resource "aws_eip" "nat" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  domain = "vpc"
}
