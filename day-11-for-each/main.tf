resource "aws_instance" "my_instance" {
  ami               = "ami-0a4408457f9a03be3"
  instance_type     = "t2.micro"
  key_name          = "my-pub-server-key"
  availability_zone = "ap-south-1a"
  for_each = toset(var.test)
  tags = {
   # Name = "dev"
     Name = each.value
  }
}
variable "test" {
    type = list(string)
    default = [ "dev","prod" ]
  
}