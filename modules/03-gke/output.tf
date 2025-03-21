output "gke_name" {
  value = google_container_cluster.gke.name
}

output "gke_endpoint" {
  value = google_container_cluster.gke.endpoint
}

output "gke_ca" {
  value = google_container_cluster.gke.master_auth[0].cluster_ca_certificate
}
