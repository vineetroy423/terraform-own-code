resource "aws_instance" "dependent" {
  ami           = "ami-068e0f1a600cd311c"
  instance_type = "t2.micro"
  key_name      = "my-pub-server-key"
  depends_on = [ aws_s3_bucket.dependent ]
}

resource "aws_s3_bucket" "dependent" {
  bucket = "aws-devops-vinnyroy"
 
}



