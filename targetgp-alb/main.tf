resource "aws_lb_target_group" "back_end" {
  name       = "backend-tg"
  port       = 80
  protocol   = "HTTP"
  vpc_id     = aws_vpc.three-tier.id
  depends_on = [aws_vpc.three-tier]

}
resource "aws_vpc" "three-tier" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "3-tietr-vpc"
  }
}

resource "aws_lb" "back_end" {
  name               = "backend-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-backend-sg.id]
  subnets            = [aws_subnet.pub1.id, aws_subnet.pub2.id]
  depends_on         = [aws_lb_target_group.back_end]
  tags = {
    Name = "ALB-backend"
  }
}
resource "aws_security_group" "alb-backend-sg" {
  name        = "alb-backend-sg"
  description = "Allow inbound traffic ALB"
  vpc_id      = aws_vpc.three-tier.id
  depends_on  = [aws_vpc.three-tier]

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-backend-sg"
  }

}

resource "aws_subnet" "pub1" {
  vpc_id                  = aws_vpc.three-tier.id
  cidr_block              = "172.20.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true # for auto asign public ip for subnet
  tags = {
    Name = "pub-1a"
  }
}

resource "aws_subnet" "pub2" {
  vpc_id                  = aws_vpc.three-tier.id
  cidr_block              = "172.20.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true # for auto asign public ip for subnet
  tags = {
    Name = "pub-2b"
  }
}

resource "aws_lb_listener" "back_end" {
  load_balancer_arn = aws_lb.back_end.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.back_end.arn
  }
  depends_on = [aws_lb_target_group.back_end]
}
resource "aws_internet_gateway" "three-tier-ig" {
    vpc_id = aws_vpc.three-tier.id
    tags = {
        Name = "3-tier-ig"
    }
}
#  creating public route table

resource "aws_route_table" "three-tier-pub-rt" {
    vpc_id = aws_vpc.three-tier.id
    tags = {
      Name = "3-tier-pub-rt"
    }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.three-tier-ig.id
  }
}

#  attaching pub-1a subnet to public route table
resource "aws_route_table_association" "public-1a" {
    route_table_id = aws_route_table.three-tier-pub-rt.id 
    subnet_id = aws_subnet.pub1.id
}

#  attaching pub-2b subnet to public route table
resource "aws_route_table_association" "public-2b" {
    route_table_id = aws_route_table.three-tier-pub-rt.id 
    subnet_id = aws_subnet.pub2.id
}



