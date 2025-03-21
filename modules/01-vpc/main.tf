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

resource "google_compute_network" "assignment_vpc" {
  name = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  network       = google_compute_network.assignment_vpc.id
  ip_cidr_range = var.subnet_cidr
  region        = var.region
}

resource "google_compute_global_address" "private_ip_address" {
  name          = var.private_ip_name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = var.private_ip_prefix_length
  network       = google_compute_network.assignment_vpc.id
}

resource "google_service_networking_connection" "private_vpc_connection" { 
  network                 = google_compute_network.assignment_vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}
