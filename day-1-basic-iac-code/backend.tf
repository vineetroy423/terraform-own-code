terraform {
  backend "s3" {
    bucket = "aws-devops-vinnyy"
    key    = "test/terraform.tfstate"
    region = "ap-south-1"
  }
}