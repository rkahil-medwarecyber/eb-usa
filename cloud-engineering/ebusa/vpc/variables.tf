##### VPC Variables #####

variable "cidr_block" {
  description = "CIDR Block for VPC"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-2"
}

variable "enable_dns_support" {
  description = "DNS Support"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "DNS Hostnames"
  type        = bool
  default     = true
}

variable "Environment" {
  description = "Environment"
  type        = string
}

variable "Client" {
  description = "Client Name"
  type        = string
}

variable "VPC_Name" {
  description = "VPC Name"
  type        = string
}

##### Public Subnet Variables #####

variable "public_subnet1_cidr" {
  description = "Public Subnet 1 CIDR "
  type        = string
}

variable "public_subnet2_cidr" {
  description = "Public Subnet 2 CIDR "
  type        = string
}

variable "az_public_subnet1" {
  description = "Availability Zone for Public Subnet 1"
  type        = string
  default     = "us-east-2a"
}

variable "az_public_subnet2" {
  description = "Availability Zone for Public Subnet 2"
  type        = string
  default     = "us-east-2b"
}

variable "public_subnet1_name" {
  description = "Public Subnet1 Name"
  type        = string
}

variable "public_subnet2_name" {
  description = "Public Subnet2 Name"
  type        = string
}

##### Private Subnet Variables #####

variable "private_subnet1_cidr" {
  description = "Private Subnet1 CIDR"
  type        = string
}

variable "private_subnet2_cidr" {
  description = "Private Subnet2 CIDR"
  type        = string
}

variable "az_private_subnet1" {
  description = "Availability Zone for Private Subnet 1"
  type        = string
  default     = "us-east-2a"
}

variable "az_private_subnet2" {
  description = "Availability Zone for Private Subnet 2"
  type        = string
  default     = "us-east-2b"
}

variable "private_subnet1_name" {
  description = "Private Subnet1 Name"
  type        = string
}

variable "private_subnet2_name" {
  description = "Private Subnet2 Name"
  type        = string
}




