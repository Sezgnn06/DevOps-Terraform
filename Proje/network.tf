resource "aws_vpc" "prdx-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = element(var.tags, 0)
  }
}

resource "aws_internet_gateway" "prdx-ig" {
  vpc_id = aws_vpc.prdx-vpc.id
  tags = {
    Name = element(var.tags, 1)
  }
}

resource "aws_subnet" "prdx-public1-subnet" {
  vpc_id            = aws_vpc.prdx-vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = element(var.tags, 2)
  }
}

resource "aws_subnet" "prdx-public-subnet" {
  vpc_id            = aws_vpc.prdx-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2b"
  tags = {
    Name = element(var.tags, 3)
  }
}

resource "aws_route_table" "prdx-rt" {
  vpc_id = aws_vpc.prdx-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prdx-ig.id
  }

  tags = {
    Name = element(var.tags, 4)
  }
}

resource "aws_route_table_association" "public1-association" {
  subnet_id      = aws_subnet.prdx-public1-subnet.id
  route_table_id = aws_route_table.prdx-rt.id
}

resource "aws_route_table_association" "public-association" {
  subnet_id      = aws_subnet.prdx-public-subnet.id
  route_table_id = aws_route_table.prdx-rt.id
}

resource "aws_eip" "terraform-eip" {
  vpc = true
  tags = {
    Name = element(var.tags, 5)
  }
}

#security group

resource "aws_security_group" "prdx-proje-sg" {
  name   = "proje-test-sg"
  vpc_id = aws_vpc.prdx-vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.cidr
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "all"
    cidr_blocks = var.cidr
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "all"
    cidr_blocks = var.cidr
  }
}

resource "aws_security_group" "prdx-proje-sg1" {
  name   = "proje-test-sg1"
  vpc_id = aws_vpc.prdx-vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.cidr
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "all"
    cidr_blocks = var.cidr
  }
}