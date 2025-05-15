output "password" {
  value = jsondecode(google_secret_manager_secret_version.sql_credentials_secret_version.secret_data)["password"]
  sensitive = true
}

output "username" {
  value = jsondecode(google_secret_manager_secret_version.sql_credentials_secret_version.secret_data)["username"]
}