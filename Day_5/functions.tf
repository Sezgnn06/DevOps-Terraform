
resource "aws_key_pair" "my-key" {
  key_name   = "Devops14-2021-key"
  public_key = file("${path.module}/my_public_key.txt")
}

  resource "aws_instance" "function-ec2" {
    ami           = lookup(var.ami , var.region)
    instance_type = "t2.micro"
    key_name      = aws_key_pair.my-key.key_name
    #  count         = 3
    tags = {
     "Name" = element(var.tags, 0)
    }
  }
  variable "ingress_ports" {
    type    = list(any)
    default = [22, 80]
  }

  variable "egress_ports" {
    type    = list(any)
    default = [0]
  }
  variable "region" {
    default = "us-east-2"
  }
  resource "aws_security_group" "dynamic-sg" {
    name = "devops14-dynamic-sg"
    dynamic "ingress" {
      for_each = var.ingress_ports
      #    iterator = port
      content {
        from_port   = ingress.value
        to_port     = ingress.value
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
    dynamic "egress" {
      for_each = var.egress_ports
      #    iterator = port
      content {
        from_port   = egress.value
        to_port     = egress.value
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
  }

  resource "aws_network_interface_sg_attachment" "sg_attachment" {
    security_group_id    = aws_security_group.dynamic-sg.id
    network_interface_id = aws_instance.function-ec2.primary_network_interface_id
  }

  locals {
   time = formatdate("DD MM YYYY hh:mm ZZZ", timestamp())
  }

  output "timestamp" {
    value = local.time
  }

  variable "ami" {
    type = map(any)
    default = {
      us-east-2 = "ami-0443305dabd4be2bc"
      us-east-1 = "ami-0c2b8ca1dad447f8a"
      us-west-1 = "ami-04b6c97b14c54de18"
      us-west-2 = "ami-083ac7c7ecf9bb9b0"
    }
  }

  variable "tags" {
    type    = list(any)
    default = ["my-first-ec2", "my-second-ec2", "my-third-ec2"]
  }

