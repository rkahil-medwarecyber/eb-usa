##### VPC Variables #####

variable "server_name" {
  description = "SFTP Server Name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "endpoint_type" {
  description = "Endpoint Type (VPC, VPC_ENDPOINT, or PUBLIC"
  type        = string
  default     = "PUBLIC"
}

variable "domain" {
  description = "Storage System for file transfers"
  type        = string
  default     = "S3"
}

variable "protocols" {
  description = "SFTP"
  type        = string
  default     = "SFTP"
}

variable "identity_provider_type" {
  description = "Mode of Authentication enabled for service"
  type        = string
  default     = "SERVICE_MANAGED"
}

variable "security_policy_name" {
  description = "Name of the Security Policy Attached to Server"
  type        = string
  default     = "TransferSecurityPolicy-FIPS-2024-01"
}

variable "sftp_authentication_method" {
  description = "For SFTP-enabled servers"
  type        = string
  default     = "PUBLIC_KEY"
}

variable "ip_address_type" {
  description = "IPV4 or Dualstack"
  type        = string
  default     = "IPV4"
}

variable "host_key" {
  description = "RSA, ECDSA, or ED25519"
  type        = string
  default     = "RSA"
}

variable "directory_listing_optimization" {
  description = "Whether or not performance for your S3 directories is optimized"
  type        = string
  default     = "ENABLED"
}


