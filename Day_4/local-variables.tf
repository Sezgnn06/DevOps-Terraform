resource "aws_instance" "ec2" {
  ami           = "ami-0443305dabd4be2bc"
  instance_type = local.instance_type
  tags          = local.common_tags
}

resource "aws_ebs_volume" "ebs" {
  availability_zone = local.az
  size              = 8
  tags              = local.common_tags
}
locals {
  common_tags = {
    "Owner"   = "Sezgin"
    "Service" = "backend"
  }
  instance_type = "t2.micro"
  az            = "us-east-2a"
}
