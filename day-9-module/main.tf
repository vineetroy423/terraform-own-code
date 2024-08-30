module "dev" {
  source        = "../day-2-all-tf-files"
  ami           = "ami-0a4408457f9a03be3"
  instance_type = "t2.micro"
  key_name      = "my-pub-server-key"

}