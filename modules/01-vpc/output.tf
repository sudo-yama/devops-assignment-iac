output "vpc_id" {
  value = google_compute_network.assignment_vpc.id
}

output "subnet_id" {
  value = google_compute_subnetwork.subnet.id
}

output "vpc_network_id" {
  value = google_compute_network.assignment_vpc.id
}

output "private_ip_address_name" {
  value = google_compute_global_address.private_ip_address.name
}