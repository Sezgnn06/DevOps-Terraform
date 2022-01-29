/*
resource "aws_instance" "test-ec2" {
  ami           = var.my_ami
  instance_type = var.instance
}

variable "instance" {
  #type    = list
  #default = ["t2.micro", "t2.large", "t2.nano", "t2.xlarge", "t2.small"]
}

variable "instance_type" {
    type = map
    default = {
        us-east-2 = "t2.micro"
        us-east-1 = "t2.nano"
        us-west-1 = "t2.large"
        us-west-2 = "t2.small"
    }
  
}

variable "ami" {
    type = map
    default = {
        us-east-2 = "ami-0443305dabd4be2bc"
        us-east-1 = "ami-0c2b8ca1dad447f8a"
        us-west-1 = "ami-04b6c97b14c54de18"
        us-west-2 = "ami-083ac7c7ecf9bb9b0"
    }
}

variable "my_ami" {
  
}
*/