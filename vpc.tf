

resource "aws_vpc" "my_vpc" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = var.project
  }
}

resource "aws_subnet" "public-1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.public_1_cidr
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-public-1"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "${var.project}-igw"
  }
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "${var.project}-rt"
  }
}

resource "aws_route_table_association" "my_route_table_association" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.my_route_table.id
}