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
    prefix  = "terraform/dev/04-helm"
  }
}

resource "google_dns_managed_zone" "i_heng_store" {
  name        = var.dns_zone_name
  dns_name    = var.domain_name
  description = "Public DNS Zone for i-heng.store"

  visibility  = "public"
}

resource "google_dns_record_set" "a_record" {
  name         = var.a_name
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.i_heng_store.name
  rrdatas      = [data.terraform_remote_state.helm.outputs.ingress_ip_address]
}

resource "google_dns_record_set" "api_cname_record" {
  name         = "${var.api_name}.${var.a_name}"
  type         = "CNAME"
  ttl          = 300
  managed_zone = google_dns_managed_zone.i_heng_store.name
  rrdatas      = ["i-heng.store."]
}

resource "google_dns_record_set" "argocd_cname_record" {
  name         = "${var.argocd_name}.${var.a_name}"
  type         = "CNAME"
  ttl          = 300
  managed_zone = google_dns_managed_zone.i_heng_store.name
  rrdatas      = ["i-heng.store."]
}

resource "google_dns_record_set" "monitor_cname_record" {
  name         = "${var.monitor_name}.${var.a_name}"
  type         = "CNAME"
  ttl          = 300
  managed_zone = google_dns_managed_zone.i_heng_store.name
  rrdatas      = ["i-heng.store."]
}