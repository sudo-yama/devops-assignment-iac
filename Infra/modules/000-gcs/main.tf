terraform {
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project
  region = var.region
}

resource "google_storage_bucket" "terraform-state" {
  name = var.gcs-name
  location = var.region
  storage_class = "STANDARD"

  versioning {
    enabled = true
  }
  
   lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 0
    }
  }
}

