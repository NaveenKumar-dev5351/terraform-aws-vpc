# 🌐 Terraform AWS VPC Module

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white)

## 🎯 Overview
Reusable Terraform module for creating a production-grade 
AWS VPC with public and private subnets, Internet Gateway, 
NAT Gateway, and Route Tables across multiple 
Availability Zones.

## 🏗️ Resources Created
- VPC with custom CIDR block
- Public subnets across multiple AZs
- Private subnets across multiple AZs
- Internet Gateway for public subnet access
- NAT Gateway for private subnet outbound access
- Route Tables for public and private subnets
- Route Table Associations

## 📋 Input Variables

| Variable | Description | Type | Required |
|---|---|---|---|
| `vpc_cidr` | CIDR block for VPC | string | ✅ Yes |
| `environment` | Environment name (dev/prod) | string | ✅ Yes |
| `public_subnets` | List of public subnet CIDRs | list(string) | ✅ Yes |
| `private_subnets` | List of private subnet CIDRs | list(string) | ✅ Yes |
| `azs` | Availability zones | list(string) | ✅ Yes |
| `project_name` | Project name for tagging | string | ✅ Yes |

## 📤 Output Values

| Output | Description |
|---|---|
| `vpc_id` | ID of the created VPC |
| `public_subnet_ids` | List of public subnet IDs |
| `private_subnet_ids` | List of private subnet IDs |
| `nat_gateway_id` | ID of the NAT Gateway |
| `internet_gateway_id` | ID of the Internet Gateway |

## 🚀 Example Usage

```hcl
module "vpc" {
  source = "./modules/terraform-aws-vpc"

  environment    = "dev"
  project_name   = "roboshop"
  vpc_cidr       = "10.0.0.0/16"
  
  azs = [
    "us-east-1a",
    "us-east-1b"
  ]
  
  public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
  
  private_subnets = [
    "10.0.10.0/24",
    "10.0.20.0/24"
  ]
}

# Reference outputs in other modules
resource "aws_instance" "bastion" {
  subnet_id = module.vpc.public_subnet_ids[0]
  vpc_id    = module.vpc.vpc_id
}
```

## 🔒 Security Considerations
- Private subnets have no direct internet access
- NAT Gateway allows outbound only from private subnets
- Route tables strictly control traffic flow

## 👨‍💻 Author
**Naveen Kumar Lingampelly**
DevOps Engineer | [LinkedIn](https://linkedin.com/in/naveenlingampelli)