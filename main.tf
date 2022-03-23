provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAYHZDZ2WGRVXB2C42"
  secret_key = "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"
}

variable "subnet_cidr_block" {
  
  description = "subnet cidr block"
}

resource "aws_vpc" "demo_vpckishoreT" {
  cidr_block = "10.0.0.0/16"
  tags={
    Name:"kishorevpc"
  }
}  
resource "aws_subnet" "demo_subnetkishoreT" {
  vpc_id     = aws_vpc.demo_vpckishoreT.id
  cidr_block = var.subnet_cidr_block
  availability_zone = "ap-south-1a"

  tags = {
    Name: "kishoresubnet"
  }
}

output  dev-vpc-id {
  value       = aws_vpc.demo_vpckishoreT.id
  
}
output  dev-subnet-id {
  value       = aws_subnet.demo_subnetkishoreT.id
  
}