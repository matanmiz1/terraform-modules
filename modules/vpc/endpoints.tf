# https://docs.aws.amazon.com/vpc/latest/privatelink/vpc-endpoints-s3.html
resource "aws_vpc_endpoint" "s3_gateway" {
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_id            = aws_vpc.this.id
  vpc_endpoint_type = "Gateway"
  route_table_ids   = aws_route_table.private.*.id

  tags = {
    Name = "${var.aws_region}-s3-gateway-vpce"
  }
}

# resource "aws_vpc_endpoint" "s3_interface" {
#   service_name        = "com.amazonaws.${var.aws_region}.s3"
#   vpc_id              = aws_vpc.this.id
#   vpc_endpoint_type   = "Interface"
#   subnet_ids          = aws_subnet.private.*.id
#   security_group_ids  = [aws_security_group.vpc_endpoints.id]
#   private_dns_enabled = true

#   tags = {
#     Name = "${var.aws_region}-s3-interface-vpce"
#   }

#   depends_on = [aws_vpc_endpoint.s3_gateway]
# }

# AWS API
resource "aws_vpc_endpoint" "ecr_api" {
  service_name        = "com.amazonaws.${var.aws_region}.ecr.api"
  vpc_id              = aws_vpc.this.id
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private.*.id
  security_group_ids  = [aws_security_group.vpc_endpoints.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.aws_region}-ecr-api-interface-vpce"
  }
}

# Docker Registry APIs
resource "aws_vpc_endpoint" "ecr_dkr" {
  service_name        = "com.amazonaws.${var.aws_region}.ecr.dkr"
  vpc_id              = aws_vpc.this.id
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private.*.id
  security_group_ids  = [aws_security_group.vpc_endpoints.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.aws_region}-ecr-dkr-interface-vpce"
  }
}
