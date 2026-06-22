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
  descripton = "Environment"
  type       = string
}

variable "Client" {
  description = "Client Name"
  type        = string
}

variable "VPC-Name" {
  description = "VPC Name"
  type        = string
}