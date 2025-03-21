variable "project" {
  description = "Project id"
  type = string
}

variable "region" {
  description = "Region"
  type = string
}

variable "dns_zone_name" {
  description = "Name of the DNS Managed Zone in Google Cloud"
}

variable "domain_name" {
  description = "The domain name for the DNS zone"
}

variable "a_name" {
  description = "A record name"
}

variable "api_name" {
  description = "Api record name"
}

variable "argocd_name" {
  description = "Argocd record name"
}

variable "monitor_name" {
  description = "Monitor record name"
}