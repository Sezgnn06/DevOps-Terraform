resource "aws_instance" "my-ec2" {
  ami           = data.aws_ami.amazon_ami.id
  instance_type = "t2.micro"

}

data "aws_ami" "amazon_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

}