variable "project" {
  description = "Project id"
  type = string
}

variable "region" {
  description = "Region"
  type = string

}

variable "db_name" {
  description = "Database name"
  type = string
}

variable "env" {
  description = "Environment"
}

variable "database_version" {
  description = "Database version"
}

variable "db_tier" {
  description = "Tier database"
}

variable "storage_size_gb" {
  description = "Storage size"
}

variable "database_name_user" {
  type = map(string)
}