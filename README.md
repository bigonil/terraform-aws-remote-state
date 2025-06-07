# terraform-aws-remote-state

Example Use Case | In Terraform, the terraform_remote_state data source lets a configuration read outputs from another Terraform configuration’s remote state. It’s mainly used to pass data (e.g., resource IDs, IP addresses, VPC IDs) between independent Terraform projects.