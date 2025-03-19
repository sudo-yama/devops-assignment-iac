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
  region  = var.region
}

data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config = {
    bucket  = "000-gcs-terraform-state"
    prefix  = "terraform/dev/01-vpc"
  }
}

resource "google_sql_database_instance" "postgres" {
  name              = "${var.db_name}-${var.env}"
  database_version  = var.database_version
  region            = var.region

  settings {
    tier                = var.db_tier
    disk_size           = var.storage_size_gb
    disk_autoresize     = true
    availability_type   = "ZONAL"
    backup_configuration {
      enabled = true
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = data.terraform_remote_state.vpc.outputs.vpc_id
    } 
  }   
  deletion_protection = false

  depends_on = [data.terraform_remote_state.vpc]  
}

resource "google_sql_database" "database" {
  for_each = var.database_name_user
  instance = google_sql_database_instance.postgres.name
  name     = each.key
}

resource "google_sql_user" "users" {
  for_each = var.database_name_user
  instance = google_sql_database_instance.postgres.name
  name     = each.key
  password = random_password.user_passwords[each.key].result
}

resource "random_password" "user_passwords" {
  for_each = var.database_name_user
  length   = 16
  special  = true
}