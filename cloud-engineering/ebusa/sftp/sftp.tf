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
  endpoint_type                  = var.endpoint_type
  domain                         = var.domain
  identity_provider_type         = var.identity_provider_type
  security_policy_name           = var.security_policy_name
  ip_address_type                = var.ip_address_type
  host_key                       = var.host_key
  directory_listing_optimization = var.directory_listing_optimization


  tags = {
    Name        = var.server_name
    Environment = var.environment
  }


}