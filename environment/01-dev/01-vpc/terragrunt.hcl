terraform {
  source = "../../../modules/01-vpc"
}

inputs = {
  project     = "develop-453608"
  vpc_name    = "dev-vpc"
  subnet_name = "dev-subnet"
  subnet_cidr = "10.0.0.0/24"
  region      = "us-central1"
}