provider "aws" {
  region = "us-east-1"
}
provider "aws" {
  region = "ap-south-1"
  alias = "mumbai"
}
resource "aws_s3_bucket" "us" {
    bucket = "my-vinnyroy-usa-bucket"
  
}
resource "aws_s3_bucket" "mumbai" {
    bucket = "my-vinnyroy-mumbai-bucket"
    provider = aws.mumbai
  
}