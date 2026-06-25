terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  # Terraform automatically reads credentials from your environment variables or ~/.aws/credentials file
}

# This data source checks your connection by fetching your AWS Account ID
data "aws_caller_identity" "current" {}

resource "aws_cloudwatch_log_group" "transfer" {
  name_prefix = var.name_prefix
}

resource "aws_iam_role" "sftp_transfer_role" {
  name = var.iam_sftp_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "transfer.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role" "sftp_transfer_logging_role" {
  name = var.iam_cloudwatch_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "transfer.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}


resource "aws_iam_role_policy_attachment" "transfer_logging_attach" {
  role       = aws_iam_role.sftp_transfer_logging_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSTransferLoggingAccess"
}

resource "aws_s3_bucket" "eb_sftp_bucket" {
  bucket = var.s3_bucket_name
  region = var.region

  tags = {
    Name        = var.s3_bucket_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "eb_versioning" {
  bucket = aws_s3_bucket.eb_sftp_bucket.id

  versioning_configuration {
    status = var.versioning
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "eb_encryption" {
  bucket = aws_s3_bucket.eb_sftp_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.sse_algorithm
    }

    blocked_encryption_types = var.blocked_encryption_types
  }
}

resource "aws_s3_bucket_policy" "eb_policy" {
  bucket = aws_s3_bucket.eb_sftp_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowListingOfUserFolder"
        Effect = "Allow"

        Principal = {
          AWS = aws_iam_role.sftp_transfer_role.arn
        }

        Action = [
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.eb_sftp_bucket.arn
        ]
      },
      {
        Sid    = "HomeDirObjectAccess"
        Effect = "Allow"

        Principal = {
          AWS = aws_iam_role.sftp_transfer_role.arn
        }

        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:GetObjectVersion",
          "s3:GetObjectACL",
          "s3:PutObjectACL"
        ]
        Resource = "${aws_s3_bucket.eb_sftp_bucket.arn}/*"
      }
    ]
  })
}

resource "tls_private_key" "sftp_transfer_host" {
  algorithm = var.host_key
  rsa_bits = 2048
}

resource "aws_transfer_server" "eb_sftp" {
  endpoint_type          = var.endpoint_type
  domain                 = var.domain
  identity_provider_type = var.identity_provider_type
  security_policy_name   = var.security_policy_name
  ip_address_type        = var.ip_address_type
  host_key               = tls_private_key.sftp_transfer_host.private_key_pem

  logging_role = aws_iam_role.sftp_transfer_logging_role.arn

  structured_log_destinations = [
  "${aws_cloudwatch_log_group.transfer.arn}:*"]

  s3_storage_options {
    directory_listing_optimization = var.directory_listing_optimization
  }

  tags = {
    Name        = var.server_name
    Environment = var.environment
  }
}