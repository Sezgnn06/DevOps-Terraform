data "aws_ami" "amazon" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

#data "template_file" "ec2_user_data" {
#  template = file("${path.module}/user_data_default.txt")
#}


resource "aws_instance" "default_page" {
  ami                         = data.aws_ami.amazon.id
  instance_type               = "t2.micro"
  key_name                    = "DevOps14"
  subnet_id                   = aws_subnet.prdx-public1-subnet.id
  vpc_security_group_ids      = [aws_security_group.prdx-proje-sg.id]
  associate_public_ip_address = true
  user_data                   = <<EOF
    #!/bin/bash
    sudo yum install -y httpd
    cd /var/www/html
    sudo wget https://s3-terraform-bucket-lab4.s3.us-east-2.amazonaws.com/default/index-default.html
    sudo wget https://s3-terraform-bucket-lab4.s3.us-east-2.amazonaws.com/default/2015-dodge-charger-srt-hellcat-front-left-angle-625x417-c.jpeg
    sudo mv index-default.html index.html
    sudo systemctl start httpd
    sudo systemctl enable httpd --now
EOF
  tags = {
    Name = "prdnx-default"
  }
}
