module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.1.0"
  instance_type          = "t2.micro"
  ami = "ami-00dfe2c7ce89a450b"
  key_name = "DevOps14"
  subnet_id  = "subnet-6fe07504"

  tags = {
      Name = "hashicorp-test"
      Owner = "Sezgin"
  }
}