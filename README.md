# 🚀 terraform-aws-remote-state

This repository demonstrates how to share infrastructure data securely across Terraform projects using AWS resources — specifically VPC + Subnets → EKS — **without directly exposing remote state**, by leveraging **AWS SSM Parameter Store**.

## 🧠 Use Case

We have two independent Terraform projects:

- `project-a-aws-vpc`: Provisions a VPC and subnets, and **publishes outputs (VPC ID, Subnet IDs)** to AWS SSM Parameter Store.
- `project-b-aws-eks`: Provisions an EKS cluster by **consuming those SSM parameters**, ensuring safe and decoupled dependency.

---

## 📁 Project Structure

```bash
terraform-aws-remote-state/
├── project-a-aws-vpc/
│   ├── main.tf
│   ├── ssm.tf
│   ├── outputs.tf
│   └── backend.tf (optional if using remote state)
│
└── project-b-aws-eks/
    ├── main.tf
    └── backend.tf (optional if using Terraform Cloud)
````

---

## ✅ What’s Included

* 🌐 VPC provisioning (`aws_vpc`)
* 🌐 Subnet provisioning (`aws_subnet`)
* 🔐 Secure output sharing via AWS SSM Parameter Store
* ☁️ Optional compatibility with Terraform Cloud Workspaces
* 🧩 EKS deployment consuming parameters from SSM

---

## 🛠️ Getting Started

### Prerequisites

* Terraform ≥ 1.3
* AWS CLI configured (`aws configure`)
* Permissions to access:

  * `SSM Parameter Store`
  * `VPC`, `Subnets`, `EKS`
  * Optional: `S3`, `Terraform Cloud`, `KMS`

---

## 🚨 Step-by-Step Deployment

### Step 1 — Deploy `project-a-aws-vpc`

```bash
cd project-a-aws-vpc
terraform init
terraform apply
```

This will:

* Create a VPC
* Create subnets
* Write VPC ID and subnet IDs to AWS SSM

---

### Step 2 — Deploy `project-b-aws-eks`

```bash
cd ../project-b-aws-eks
terraform init
terraform apply
```

This will:

* Fetch `vpc_id` and `subnet_id` values from SSM
* Use them to deploy an EKS cluster

---

## 🔒 Security Notes

* All sensitive cross-project data is shared through SSM with fine-grained IAM access.
* You can optionally encrypt SSM parameters using a custom KMS key.
* No remote state file is exposed — you avoid the risk of leaking secrets across teams.

---

## 🧱 Future Improvements

* Multi-AZ Subnet support
* Module abstraction
* EKS node group configuration
* Cross-region VPC sharing
* Terraform Cloud remote state output usage

---

## 🧑‍💻 Authors

**Maintainer**: [Your Name or Org](https://github.com/your-profile)
**Terraform Design**: 🔨🤖 `@terraform-aws-remote-state`

---

## 📜 License

MApache 2.0 IT License. See [LICENSE](./LICENSE) for full text.

---

## 🤝 Contributing

Issues and PRs welcome! Feel free to fork and customize this pattern to match your cloud strategy and organization’s standards.

---

## 👀 Example Output

Once deployed, you’ll see your parameters in AWS:

* `/shared/vpc/id`
* `/shared/subnet/public/a`
* `/shared/subnet/private/a`

You can check them with:

```bash
aws ssm get-parameter --name "/shared/vpc/id"
```

---

Enjoy ✨ safe, composable, and production-ready Terraform workflows!

```