# 🌐 Terraform AWS VPC Module

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white)

## 🎯 Overview
Production-grade reusable Terraform module for AWS VPC
with three-tier subnet architecture — public, private,
and database subnets across multiple Availability Zones.

## 🏗️ Resources Created
- VPC with DNS hostnames enabled
- Public subnets (count based — dynamic)
- Private subnets (count based — dynamic)
- Database subnets (count based — dynamic)
- Internet Gateway
- Elastic IP for NAT Gateway
- NAT Gateway in public subnet
- Public Route Table → IGW
- Private Route Table → NAT Gateway
- Database Route Table → NAT Gateway
- Route Table Associations for all subnet types

## 🏗️ Architecture
Internet
│
▼
Internet Gateway
│
▼
Public Subnets (us-east-1a, us-east-1b)
│
├── NAT Gateway (with Elastic IP)
│         │
│         ▼
│   Private Subnets (us-east-1a, us-east-1b)
│         │
│         ▼
│   Database Subnets (us-east-1a, us-east-1b)

## 📋 Input Variables

| Variable | Description | Type | Required |
|---|---|---|---|
| `cidr_block` | VPC CIDR block | string | ✅ Yes |
| `project` | Project name | string | ✅ Yes |
| `environment` | Environment (dev/prod) | string | ✅ Yes |
| `public_subnet_cidrs` | List of public CIDRs | list(string) | ✅ Yes |
| `private_subnet_cidrs` | List of private CIDRs | list(string) | ✅ Yes |
| `database_subnet_cidrs` | List of database CIDRs | list(string) | ✅ Yes |
| `vpc_tags` | Additional VPC tags | map(string) | ❌ No |
| `igw_tags` | Additional IGW tags | map(string) | ❌ No |
| `nat_gateway_tags` | Additional NAT tags | map(string) | ❌ No |
| `public_subnet_tags` | Public subnet tags | map(string) | ❌ No |
| `private_subnet_tags` | Private subnet tags | map(string) | ❌ No |
| `database_subnet_tags` | Database subnet tags | map(string) | ❌ No |

## 📤 Output Values

| Output | Description |
|---|---|
| `vpc_id` | ID of created VPC |
| `public_subnet_ids` | List of public subnet IDs |
| `private_subnet_ids` | List of private subnet IDs |
| `database_subnet_ids` | List of database subnet IDs |
| `nat_gateway_id` | NAT Gateway ID |
| `internet_gateway_id` | Internet Gateway ID |

## 🚀 Example Usage

```hcl
module "vpc" {
  source = "git::https://github.com/NaveenKumar-dev5351/terraform-aws-vpc.git"

  project     = "roboshop"
  environment = "dev"
  cidr_block  = "10.0.0.0/16"

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]

  database_subnet_cidrs = [
    "10.0.21.0/24",
    "10.0.22.0/24"
  ]
}

# Use outputs in other modules
module "security_groups" {
  source = "../terraform-aws-sg"
  vpc_id = module.vpc.vpc_id
}
```

## ✅ Features
- ✅ Three-tier subnet architecture
- ✅ Dynamic subnet creation using count
- ✅ AZ-aware subnet naming
- ✅ Consistent tagging using merge()
- ✅ Proper NAT Gateway dependency chain
- ✅ Separate route tables per tier
- ✅ DNS hostnames enabled

## 🔒 Security Design
- Database subnets have NO direct internet access
- Private subnets use NAT for outbound only
- Only public subnets have IGW route
- Proper subnet isolation per tier

## 👨‍💻 Author
**Naveen Kumar Lingampelly**
DevOps Engineer | [LinkedIn](https://linkedin.com/in/naveenlingampelli)