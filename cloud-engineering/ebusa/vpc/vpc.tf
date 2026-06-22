terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  # Terraform automatically reads credentials from your environment variables or ~/.aws/credentials file
}

# This data source checks your connection by fetching your AWS Account ID
data "aws_caller_identity" "current" {}

resource "aws_vpc" "eb_usa_vpc" {
  cidr_block            = var.cidr_block
  enable_dns_support    = var.enable_dns_support
  enable_dns_hostnames  = var.enable_dns_hostnames

  tags {
    Name                = var.VPC-Name
    Environment         = var.Environment
    Client              = var.Client
  }
}




