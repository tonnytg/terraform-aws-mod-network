output "vpc_id" {
  value = aws_vpc.this.id
}

output "vpc_cidr_block" {
  value = aws_vpc.this.cidr_block
}

output "internet_gateway_id" {
  value = aws_internet_gateway.this.id
}

output "eip_id" {
  value = aws_eip.this.id
}

output "eip_public_ip" {
  value = aws_eip.this.public_ip
}
