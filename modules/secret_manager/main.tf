resource "google_secret_manager_secret" "secret-basic" {
  secret_id = var.secret_manager_name

  labels = {
    user_name = var.username
  }

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "random_password" "sql_password" {
  length            = 11
  special           = true
  override_special  = "!@#$%^&*()_+"
}

resource "google_secret_manager_secret_version" "sql_credentials_secret_version" {
  provider = google-beta

  secret = google_secret_manager_secret.secret-basic.name

  secret_data = jsonencode({
    username = var.username
    password = random_password.sql_password.result
  })
}
