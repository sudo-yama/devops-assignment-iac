output "vpc_id" {
  value = google_compute_network.assignment_vpc.id
}

output "subnet_id" {
  value = google_compute_subnetwork.subnet.id
}