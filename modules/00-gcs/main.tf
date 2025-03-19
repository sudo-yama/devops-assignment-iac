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

data "google_storage_bucket" "existing" {
  name = var.gcs-name
}

resource "google_storage_bucket" "terraform_state" {
  count         = length(data.google_storage_bucket.existing.name) > 0 ? 0 : 1
  name          = var.gcs-name
  location      = var.region
  storage_class = "STANDARD"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
