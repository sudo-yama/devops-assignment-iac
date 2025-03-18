variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "subnet_cidr" {
  description = "Subnet CIDR"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "project" {
  description = "Project id"
  type = string
}

