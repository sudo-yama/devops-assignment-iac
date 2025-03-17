output "bucket_name" {
  description = "The name of the Terraform state bucket"
  value       = google_storage_bucket.terraform-state.name
}

output "bucket_url" {
  description = "The URL of the Terraform state bucket"
  value       = "gs://${google_storage_bucket.terraform-state.name}"
}

output "bucket_location" {
  description = "The location of the Terraform state bucket"
  value       = google_storage_bucket.terraform-state.location
}
