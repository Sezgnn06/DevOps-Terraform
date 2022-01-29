resource "aws_instance" "Manual" {
    ami           = "ami-00dfe2c7ce89a450b"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["sg-09046a8903d486dc7"]
    key_name = "DevOps14"
    subnet_id = "subnet-ead91a97"
    tags = {
      Name = "Manual"
    }
}

resource "aws_s3_bucket" "import" {
  bucket = "cloud-front-example-devops134579065"
  acl    = "private"
  provider = aws.Oregon
}