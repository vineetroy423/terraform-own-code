resource "aws_instance" "my-instance" {
  ami                         = "ami-0a4408457f9a03be3"
  key_name                    = "my-pub-server-key"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.priv_subnet.id
  vpc_security_group_ids      = [aws_security_group.cust-sg.id]
  tags = {
    Name = "my-dev-server"
  }
}