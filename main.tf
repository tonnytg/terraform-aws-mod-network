###
# VPC
###
resource "aws_vpc" "this" {
  cidr_block = var.cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = format("%s-vpc", var.project_name)
  }

}

data "aws_availability_zones" "a" {
  state = "available"
}

###
# Subnet-Public
###
resource "aws_subnet" "public" {
  count = length(var.cidr_blocks_pub)

  vpc_id = aws_vpc.this.id

  cidr_block              = var.cidr_blocks_pub[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.a.names[count.index]

  tags = {
    Name = format("%s-public", var.project_name)
  }
}

###
# Internet Gateway
###
# Internet Gateway allow Public Subnet to access Internet
resource "aws_internet_gateway" "this" {

  vpc_id = aws_vpc.this.id

  tags = {
    Name = format("%s-ig", var.project_name)
  }

}

###
# Route attach to subnet
###
# Add route 0.0.0.0/0 to in and out
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = format("%s-public-rt", var.project_name)
  }

}

resource "aws_route_table_association" "public" {
  count = length(var.cidr_blocks_pri)

  subnet_id = aws_subnet.public.*.id[count.index]

  route_table_id = aws_route_table.public.*.id[0]

  depends_on = [
    aws_subnet.public
  ]
}

##
# Elastic IP
###
# This IP will be used on NAT Gateway
resource "aws_eip" "this" {
  vpc = true

  tags = {
    "Name" = format("%s-elastic-ip", var.project_name)
  }

}


####
## NAT Gateway
####
#
## Associate NAT Gateway with Public Subnet, this get one IP address
## of Public Subnet and allow traffic there
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id

  subnet_id = aws_subnet.public.*.id[0]

  tags = {
    Name = format("%s-nat-gateway", var.project_name)
  }

  depends_on = [aws_internet_gateway.this]

}
#
resource "aws_route_table" "nat" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name = format("%s-private-rt", var.project_name)
  }

}
###
## Private Subnet
####
resource "aws_subnet" "private" {
  count = length(var.cidr_blocks_pri)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.cidr_blocks_pri[count.index]
  availability_zone = data.aws_availability_zones.a.names[count.index]

  tags = {
    Name = format("%s-private", var.project_name)
  }
}


resource "aws_route_table_association" "private" {
  count = length(var.cidr_blocks_pri)

  subnet_id = aws_subnet.private.*.id[count.index]

  route_table_id = aws_route_table.nat.*.id[0]

  depends_on = [
    aws_subnet.private
  ]
}
