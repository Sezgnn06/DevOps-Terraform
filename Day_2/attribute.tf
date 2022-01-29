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

resource "aws_eip" "my_eip" {
  vpc = true
  tags = {
    Name  = "my_eip"
    Owner = "Sezgin"
  }
}
variable "my_ami" {
  default = "ami-0443305dabd4be2bc"
}

variable "instance_type" {
  default = "t2.micro"
}
resource "aws_instance" "my-first-ec2" {
  ami           = var.my_ami
  instance_type = var.instance_type
  tags = {
    Name  = "myec2-1"
    Owner = "Sezgin"
  }
}

resource "aws_instance" "my-second-ec2" {
  ami           = var.my_ami
  instance_type = var.instance_type
  tags = {
    Name  = "myec2-1"
    Owner = "Sezgin"
  }
}

resource "aws_instance" "my-third-ec2" {
  ami           = var.my_ami
  instance_type = var.instance_type
  tags = {
    Name  = "myec2-1"
    Owner = "Sezgin"
  }
}
resource "aws_eip_association" "my_eip_to_ec2" {
  instance_id   = aws_instance.my-first-ec2.id
  allocation_id = aws_eip.my_eip.id

}

output "eip" {
  value = aws_eip.my_eip.public_ip
}

output "my_ec2_public_dns" {
  value = aws_instance.my-first-ec2.public_dns
}

resource "aws_security_group" "my-sg" {
  name        = "my-terraform-example-sg"
  description = "we are testing terraform"
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    #     cidr_blocks = [aws_eip.my_eip.public_ip/32] version 0.12 or earlier
    cidr_blocks = ["${aws_eip.my_eip.public_ip}/32"] # version 0.13 or newer
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "tf-example-sg"
    Owner = "Sezgin"
  }
}

resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = aws_security_group.my-sg.id
  network_interface_id = aws_instance.my-first-ec2.primary_network_interface_id
}