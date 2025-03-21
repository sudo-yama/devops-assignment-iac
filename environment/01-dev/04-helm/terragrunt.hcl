terraform {
  source = "../../../modules/04-helm"
}

remote_state {
  backend = "gcs"
  config = {
    bucket  = "000-gcs-terraform-state"
    prefix  = "terraform/dev/05-helm"
    location = "us-central1"
    project  = "develop-453608"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}

inputs = {
  project           = "develop-453608"
  region            = "us-central1"
  ingress_namespace = "ingress-nginx"
  argocd_namespace  = "argocd"
}