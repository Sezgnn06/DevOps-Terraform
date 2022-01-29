module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "6.5.0"
   name = "my-alb"
    load_balancer_type = "application"
    vpc_id             = "vpc-a7325fcc"
    subnets   = ["subnet-ead91a97" ,"subnet-79a88335"]
}