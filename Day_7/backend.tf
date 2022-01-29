terraform {
  backend "s3" {
    bucket         = "gs-1905"
    region         = "us-east-2"
    profile        = "prod"
    key            = "terraform.tfstate"
    dynamodb_table = "Devops14-lock-table"
  }
}