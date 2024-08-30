module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name          = "single-instance"
  ami           = "ami-0a4408457f9a03be3"
  instance_type = "t2.micro"
  key_name      = "my-pub-server-key"
  subnet_id     = "subnet-0572b2d54dfc0a6d8"

}
