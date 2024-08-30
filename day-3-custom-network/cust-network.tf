# create vpc
resource "aws_vpc" "cust-network-vpc" {
  tags = {
    Name = "my-cust-vpc"
  }
  cidr_block = "10.0.0.0/16"
}
# create internet gateway and attach to vpc
resource "aws_internet_gateway" "cust-ig" {
  tags = {
    Name = "my-ig"
  }
  vpc_id = aws_vpc.cust-network-vpc.id

}
# create subnet
resource "aws_subnet" "pub-subnet" {
  tags = {
    Name = "public-subnet"
  }
  vpc_id            = aws_vpc.cust-network-vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-south-1a"

}
resource "aws_subnet" "priv-subnet" {
  tags = {
    Name = "private-subnet"
  }
  vpc_id            = aws_vpc.cust-network-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1b"

}
# create route table attach to ig(edit route ig to rt)
resource "aws_route_table" "public-rt" {
  tags = {
    Name = "public-rt"
  }
  vpc_id = aws_vpc.cust-network-vpc.id
  route {
    gateway_id = aws_internet_gateway.cust-ig.id
    cidr_block = "0.0.0.0/0"
  }
}
# subnet association give routing from rt to subnet
resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.pub-subnet.id
  route_table_id = aws_route_table.public-rt.id
}
# create security group
resource "aws_security_group" "cust-sg" {
  name   = "cust-sg"
  vpc_id = aws_vpc.cust-network-vpc.id
  tags = {
    Name = "my-cust-sg"
  }
  ingress {
    description = "allow http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

