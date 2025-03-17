terraform {
  source = "../../modules/000-gcs"
}

inputs = {
  project  = "my-gcp-project-dev"
  region   = "us-central1"
  gcs_name = "000-gcs-terraform-state-dev"
}
