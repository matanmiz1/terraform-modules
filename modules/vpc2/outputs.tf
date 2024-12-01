output "vpc_id" {
  value = aws_vpc.this.id
}

output "private_subnets" {
  value = [ for s in aws_subnet.private: s.id ]
}
