resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.this.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "vpc_endpoints" {
  vpc_id = aws_vpc.this.id

  ingress {
    description = "Allow inbound HTTPS traffic from the private subnets."
    protocol = "TCP"
    from_port = 443
    to_port = 443
    cidr_blocks = aws_subnet.private[*].cidr_block
  }
}
# TODO: also from client VPN
