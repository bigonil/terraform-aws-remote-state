terraform {
  backend "s3" {
    bucket         = "tf-remote-state-8g2xj9g3"
    key            = "project-a/vpc/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
provider "aws" {
  region  = "us-west-2"
  profile = "lb-aws-admin"
}
