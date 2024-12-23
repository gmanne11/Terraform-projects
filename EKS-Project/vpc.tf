provider "aws" {
    region = var.region
}

data "aws_availability_zones" "avaialble"{}

locals {
  cluster_name = "vivi-eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
    length = 8
    special = false
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.7.0"

  name = "vivi-eks-vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.avaialble.names
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}