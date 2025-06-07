terraform {
  backend "s3" {
    bucket = "tf-remote-state-8g2xj9g3"
    key    = "project-b/eks/terraform.tfstate"
    region = "us-west-2"
  }
}