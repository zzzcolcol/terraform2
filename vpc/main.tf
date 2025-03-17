resource "aws_vpc" "this" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = var.vpc_name
    }
}

resource "aws_subnet" "public" {
    count = length(var.public_subnets)
    vpc_id = aws_vpc.this.id
    cidr_block = element(var.public_subnets, count.index)
    map_public_ip_on_launch = true
    availability_zone = element(var.availability_zones, count.index)
}

resource "aws_subnet" "private" {
    count = length(var.private_subnets)
    vpc_id = aws_vpc.this.id
    cidr_block = element(var.private_subnets, count.index)
    availability_zone = element(var.availability_zones, count.index)  
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "vpc-igw"
  }
}

resource "aws_eip" "nat-gw" {
    depends_on = [aws_internet_gateway.igw]
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat-gw.id
  subnet_id     = element(aws_subnet.public[*].id, 0)

  tags = {
    Name = "gw NAT"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = var.public_subnets[count.index]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
        Name = "private-route-table"
    }
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)
  subnet_id = var.private_subnets[count.index]
  route_table_id = aws_route_table.private.id
}

