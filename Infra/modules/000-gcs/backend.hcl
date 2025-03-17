remote_state {
  backend = "gcs"
  config = {
    bucket         = "000-gcs-terraform-state"
    prefix         = "terraform/state"
    location       = "us-central1"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  dependencies = ["../modules/gcs"]
}