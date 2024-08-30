resource "aws_instance" "dependent" {
  ami           = "ami-068e0f1a600cd311c"
  instance_type = "t2.micro"
  key_name      = "my-pub-server-key"
}

resource "aws_s3_bucket" "dependent" {
  bucket = "ytvhshfbbcbucketvinny"
}
#if we want to create specific resource from configuration file we can use target block
#ex- terraform destroy --target=aws_s3_bucket.dependent
#terraform apply --target=aws_s3_bucket.dependent