variable "env" {
}

resource "aws_instance" "dev" {
  ami = "ami-0443305dabd4be2bc"
  instance_type = "t2.micro"
  count = var.env == true ? 3:1 
}
resource "aws_instance" "prod" {
  ami = "ami-0443305dabd4be2bc"
  instance_type = "t2.micro"
  count = var.env == false ? 1:2
}