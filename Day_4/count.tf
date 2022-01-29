/*
resource "aws_instance" "ec2" {
  ami = "ami-0443305dabd4be2bc"
  instance_type = "t2.micro"
  count = 4
}

resource "aws_iam_user" "my_user" {
  name = var.users[count.index]
  path = "/system/"
  count = 5 
}

variable "users" {
  type = list
  default = ["user1","user2","user3","user4","user5"]
  
}
*/