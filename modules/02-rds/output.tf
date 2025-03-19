output "instance_name" {
  value = google_sql_database_instance.postgres.name
}

output "databases" {
  value = { for k, v in google_sql_database.database : k => v.name}
}

output "users" {
  value = { for k, v in google_sql_user.users : k => v.name }
}
