terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.34.0,<=3.35.0"
    }
  }
}

provider "aws" {
  region  = "us-east-2"
  profile = "prod"
}

provider "aws" {
  region  = "us-west-2"
  profile = "prod"
  alias = "Oregon"
}