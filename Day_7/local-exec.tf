/*
data "aws_ami" "amazon" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "my-instance" {
  ami           = data.aws_ami.amazon.id
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${aws_instance.my-instance.public_ip} >> private_ips.txt"
  }

  tags = {
    "Name" = "local-exec"
  }
}
*/