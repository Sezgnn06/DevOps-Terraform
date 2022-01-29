terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.51"
    }
  }
}

provider "aws" {
  region  = "us-east-2"
  profile = "prod"
}