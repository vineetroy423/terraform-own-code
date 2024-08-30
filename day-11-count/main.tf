resource "aws_instance" "my_instance" {
  ami               = "ami-0a4408457f9a03be3"
  instance_type     = "t2.micro"
  key_name          = "my-pub-server-key"
  availability_zone = "ap-south-1a"
  count             = length(var.test)
  tags = {
   # Name = "dev"
    #Name = "web-${count.index}"
    Name = var.test[count.index]
  }
}
variable "test" {
    type = list(string)
    default = [ "dev","prod" ]
  
}