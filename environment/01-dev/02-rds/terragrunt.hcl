terraform {
  source = "../../../modules/02-rds"
}

remote_state {
  backend = "gcs"
  config = {
    bucket  = "000-gcs-terraform-state"
    prefix  = "terraform/dev/02-rds"
    location = "us-central1"
    project  = "develop-453608"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}

inputs = {
  project            = "develop-453608"
  region             = "us-central1"
  env                = "dev"
  db_name            = "golang"
  database_version   = "POSTGRES_15"
  db_tier            = "db-f1-micro"
  storage_size_gb    = "10"
  database_name_user = {
    "app_db" = "app_user"
    "logs_db" = "logs_user"
  }
}