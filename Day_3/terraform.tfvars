#protocol = "udp"
cidr                = "192.168.1.11/32"
instance_type       = "t2.small"
bucket_name         = "my-gs-demoo-bucket-devops21-class"
elb_name            = "my-lb"
az                  = ["us-east-2a", "us-east-2b"]
connection_draining = true
