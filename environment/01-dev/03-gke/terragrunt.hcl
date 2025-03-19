terraform {
  source = "../../../modules/03-gke"
}

remote_state {
  backend = "gcs"
  config = {
    bucket  = "000-gcs-terraform-state"
    prefix  = "terraform/dev/03-gke"
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
  env            = "dev"
  cluster_name   = "dev-gke"
  node_count     = 2
  machine_type   = "e2-micro"
  node_disk_size = 50
}