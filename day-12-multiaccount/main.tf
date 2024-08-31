provider "aws" {
  profile = "default"
  alias = "dev"
  region = "us-east-1"
}
provider "aws" {
  profile = "account2"
  alias = "test"
  region = "ap-south-1"
}
resource "aws_s3_bucket" "account1-buck" {
    bucket = "vineet-roy-account1-bucket"
    provider = aws.dev
  
}
resource "aws_s3_bucket" "account2-buck" {
    bucket = "vineet-roy-account2-bucket"
    provider = aws.test
}