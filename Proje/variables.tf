variable "region" {
}
variable "cidr" {
}

variable "tags" {
  type    = list(any)
  default = ["terraform-vpc-prdx", "terraform-ig-prdx", "terraform-public1-subnet-prdx", "terraform-public-subnet-prdx", "terraform-public-rt-prdx", "terraform-eip-prdx", "terraform-nat-gw-prdx"]
}