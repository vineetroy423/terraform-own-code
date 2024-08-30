resource "aws_instance" "my_instance" {
  ami               = "ami-0a4408457f9a03be3"
  instance_type     = "t2.micro"
  key_name          = "my-pub-server-key"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "dev-backend-dev12"
  }
  #lifecycle{
  # prevent_destroy= false
  #}
  #lifecycle {
  # ignore_changes = [tags, ]
  #}
  # lifecycle {
  #  create_before_destroy = true
  #}
}
