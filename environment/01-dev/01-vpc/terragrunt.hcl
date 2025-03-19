terraform {
  source = "../../../modules/01-vpc"
}

remote_state {
  backend = "gcs"
  config = {
    bucket  = "000-gcs-terraform-state"
    prefix  = "terraform/dev/01-vpc"
    location = "us-central1"
    project  = "develop-453608"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}

inputs = {
  project                   = "develop-453608"
  vpc_name                  = "dev-vpc"
  subnet_name               = "dev-subnet"
  subnet_cidr               = "10.0.0.0/24"
  region                    = "us-central1"
  private_ip_name           = "google-managed-services"
  private_ip_prefix_length  = "16"
}