resource "aws_instance" "manual" {
    ami           = "ami-00dfe2c7ce89a450b"
    instance_type = "t2.micro"

    tags = {
      Name = "sensitive"
    }
}

locals {
    db_password = {
        admin = "password"
    }
}

output "db_password" {
    value = local.db_password
    sensitive = true
}

