provider "google" {
  project = var.project
  region = var.region
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