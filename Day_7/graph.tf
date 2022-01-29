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
  instance_type = "t2.nano"
  tags = {
    "Name" = "graph"
  }
}
resource "aws_eip" "eip" {
  vpc = true
  tags = {
    "Name" = "graph-eip"
  }
}

resource "aws_eip_association" "graph_eip" {
  instance_id   = aws_instance.my-instance.id
  allocation_id = aws_eip.eip.id

}

*/