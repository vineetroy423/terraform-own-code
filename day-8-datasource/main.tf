data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["pub-subnet-1"]
  }
}
data "aws_ami" "amzlinux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.5.20240819.0-kernel-6.1-arm64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
}
resource "aws_instance" "dependent" {
  ami               = data.aws_ami.amzlinux.id
  instance_type     = "a1.medium"
  key_name          = "my-usa-key12"
  subnet_id         = data.aws_subnet.selected.id
  availability_zone = "us-east-1a"
}