variable "project" {
  description = "Project id"
  type = string
}

variable "region" {
  description = "Region"
  type = string
}

variable "env" {
  description = "Environment"
}

variable "cluster_name" {
  description = "Google Kubernetes cluster name"
}

variable "node_count" {
  description = "Node Kubernetes"
}

variable "machine_type" {
  description = "Machine type"
}

variable "node_disk_size" {
  description = "Node disk size"
}