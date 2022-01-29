resource "aws_instance" "my-ec2" {
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = var.subnet
}