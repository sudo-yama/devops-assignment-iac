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

variable "min_node" {
  description = "Min node Kubernetes"
}

variable "max_node" {
  description = "Max node Kubernetes"
}

variable "machine_type" {
  description = "Machine type"
}

variable "node_disk_size" {
  description = "Node disk size"
}