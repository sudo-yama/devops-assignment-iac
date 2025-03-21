terraform {
  source = "../../../modules/05-domain"
}

remote_state {
  backend = "gcs"
  config = {
    bucket  = "000-gcs-terraform-state"
    prefix  = "terraform/dev/04-domain"
    location = "us-central1"
    project  = "develop-453608"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}

inputs = {
  project        = "develop-453608"
  region         = "us-central1"
  dns_zone_name  = "i-heng-store-zone"
  domain_name    = "i-heng.store."
  a_name         = "i-heng.store."
  api_name       = "api"
  argocd_name    = "argocd"
  monitor_name   = "grafana"
}