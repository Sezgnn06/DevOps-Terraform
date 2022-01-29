variable "protocol" {
  type = string
}

variable "cidr" {
  default = string
}
variable "instance_type" {
  default = "t2.micro"
}
variable "bucket_name" {

}

variable "instance_type" {
}
variable "elb_name" {
  default = string

}

variable "az" {
  type = list
}

variable "connection_draining" {
  type = bool
}