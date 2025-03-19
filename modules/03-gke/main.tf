terraform {
  required_providers {
    google = {
        source  = "hashicorp/google"
        version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config = {
    bucket  = "000-gcs-terraform-state"
    prefix  = "terraform/dev/01-vpc"
  }
}

resource "google_container_cluster" "gke" {
  name                     = "${var.cluster_name}-${var.env}"
  location                 = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network                  = data.terraform_remote_state.vpc.outputs.vpc_id
  subnetwork               = data.terraform_remote_state.vpc.outputs.subnet_id

  deletion_protection = false

  ip_allocation_policy {}
  
}

resource "google_container_node_pool" "primary_nodes" {
  name                     = "${var.cluster_name}-node-pool"
  location                 = var.region
  cluster                  = google_container_cluster.gke.name
  node_count               = var.node_count

  node_config {
    preemptible  = false
    machine_type = var.machine_type
    disk_size_gb = var.node_disk_size
    oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

