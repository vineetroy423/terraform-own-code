resource "aws_instance" "my-instance" {
  ami                         = "ami-0a4408457f9a03be3"
  key_name                    = "my-pub-server-key"
  instance_type               = "t2.micro"
  associate_public_ip_address = "true"
  tags = {
    Name = "my-devops"
  }
}