terraform {
  source = "../../../modules/00-gcs"
}

remote_state {
  backend = "gcs"
  config = {
    bucket  = "000-gcs-terraform-state"
    prefix  = "terraform/dev/00-gcs"
    location = "us-central1"
    project  = "develop-453608"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}

inputs = {
  project     = "develop-453608"
  region      = "us-central1"
  gcs-name    = "000-gcs-terraform-state"
}