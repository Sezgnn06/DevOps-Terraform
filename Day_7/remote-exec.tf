data "aws_ami" "amazon" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_key_pair" "my-key" {
  key_name   = "devops14-tf-key-1"
  public_key = file("${path.module}/my_public_key.txt")
}

resource "aws_instance" "remote-ec2" {
  ami                    = data.aws_ami.amazon.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.my-key.id
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  subnet_id = aws_subnet.my-public-subnet.id
  associate_public_ip_address = true

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd --now"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./private_key.pem")
      host        = self.public_ip
    }
  }
}

resource "aws_security_group" "my-sg" {
  name = "remote-ssh"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}