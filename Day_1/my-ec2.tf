terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.34.0,<=3.35.0"
    }
  }
}

provider "aws" {
  region     = "us-east-2"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "my-first-ec2" {
  ami           = "ami-0443305dabd4be2bc"
  instance_type = "t2.micro"
  tags = {
    Name  = "myec2-1"
    Owner = "Sezgin"
  }
}

resource "aws_instance" "my-second-ec2" {
  ami           = "ami-0443305dabd4be2bc"
  instance_type = "t2.micro"
  tags = {
    Name  = "myec2-2"
    Owner = "Sezgin"
  }
}
