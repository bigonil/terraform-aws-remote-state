provider "aws" {
  region  = "us-west-2"
  profile = "lb-aws-admin"
}

### SSM parameters (provided keys)
data "aws_ssm_parameter" "vpc_id" {
  name = "/network/vpc_id"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/network/private_subnet_ids"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/network/public_subnet_ids"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.8.4" # Or the latest stable version
  cluster_name    = "my-eks"
  cluster_version = "1.29"

  vpc_id     = data.aws_ssm_parameter.vpc_id.value
  subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)

  enable_irsa = true

  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      max_size       = 3
      min_size       = 1
      instance_types = ["t3.medium"]
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}