output "aws_vpc_id" {
  value = aws_vpc.this.id
}

output "aws_vpc_cidr_block" {
  value = aws_vpc.this.cidr_block
}

output "aws_internet_gateway_id" {
  value = aws_internet_gateway.this.id
}

output "aws_eip_id" {
  value = aws_eip.this.id
}

output "aws_eip_public_ip" {
  value = aws_eip.this.public_ip
}
