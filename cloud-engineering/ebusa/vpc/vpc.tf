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


locals {
  public_subnets = {
    subnet_1 = aws_subnet.public_subnet_1.id
    subnet_2 = aws_subnet.public_subnet_2.id
  }
}

resource "aws_vpc" "eb_usa_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name        = var.VPC_Name
    Environment = var.Environment
    Client      = var.Client
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.eb_usa_vpc.id
  cidr_block        = var.public_subnet1_cidr
  availability_zone = var.az_public_subnet1

  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet1_name
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.eb_usa_vpc.id
  cidr_block        = var.public_subnet2_cidr
  availability_zone = var.az_public_subnet2

  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet2_name
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.eb_usa_vpc.id
  cidr_block        = var.private_subnet1_cidr
  availability_zone = var.az_private_subnet1

  tags {
    Name = var.private_subnet1_name
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.eb_usa_vpc.id
  cidr_block        = var.private_subnet2_cidr
  availability_zone = var.az_private_subnet2

  tags {
    Name = var.private_subnet2_name
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.eb_usa_vpc.id

  tags = {
    Name = "EB-InternetGW-Dev"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.eb_usa_vpc.id
}

resource "aws_route" "public_routing" {
  route_table_id         = aws_route_table.public_route.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gateway.id
}

resource "aws_route_table_association" "public_association" {
  for_each = local.public_subnets

  subnet_id      = each.value
  route_table_id = aws_route_table.public_route.id
}