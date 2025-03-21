variable "project" {
  description = "Project id"
  type = string
}

variable "region" {
  description = "Region"
  type = string
}

variable "ingress_namespace" {
  description = "Namespace ingress"
}

variable "argocd_namespace" {
  description = "Namespace argocd"
}