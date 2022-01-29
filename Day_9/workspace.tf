/*
resource "aws_instance" "my-first-ec2" {
  ami           = "ami-00dfe2c7ce89a450b"
  instance_type = lookup(var.instance_type , terraform.workspace)
  tags = {
    Name  = "myec2-1"
    Owner = "Sezgin"
  }
}

variable "instance_type" {
     type = map
     default = {
         dev = "t2.nano"
         prod = "t2.large"
         test = "t2.small"
         default = "t2.micro"
     }
}
*/