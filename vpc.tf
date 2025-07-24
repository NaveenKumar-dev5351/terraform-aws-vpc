resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = "true"

  tags = merge (
    local.common_tags,
    {
        name = "${var.project}-${var.environment}"
    }
  )
  }
  
  resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id #association with vpc

  tags = merge (
    local.common_tags,
    {
        name = "${var.project}-${var.environment}"
    }
  )
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = 

  tags = {
    Name = "Main"
  }
}