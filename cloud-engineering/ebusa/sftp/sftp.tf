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

resource "aws_transfer_server" "eb_sftp" {
  tags = {
    Name = var.server_name
  }

  
}