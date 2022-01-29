module "ec2" {
    source = "/root/DevOps14-terraform/Day_8/Modules/ec2"
    instance_type = "t2.small"
    subnet = "subnet-6fe07504"
  
}