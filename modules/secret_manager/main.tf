# Main configuration for the Secret Manager module

locals {
  # Ensure secret_ids is a set for safe iteration
  secret_ids_set = toset(var.secret_ids)

  # Create maps for secrets based on replication type
  automatic_secrets = {
    for id in local.secret_ids_set : id => id if var.replication == "automatic"
  }
  user_managed_secrets = {
    for id in local.secret_ids_set : id => id if var.replication == "user_managed"
  }
}

# Create secrets with AUTOMATIC replication
resource "google_secret_manager_secret" "secrets_auto" {
  for_each = local.automatic_secrets

  project   = var.project_id
  secret_id = each.value

  # Correct static replication block for automatic using the validated 'auto {}' block
  replication {
    auto {}
  }

  labels = var.labels

  # Optional: Set expiration policy directly as arguments
  expire_time = var.expire_time
  ttl         = var.ttl
}

# Create secrets with USER_MANAGED replication
resource "google_secret_manager_secret" "secrets_user" {
  for_each = local.user_managed_secrets

  project   = var.project_id
  secret_id = each.value

  # Correct static replication block for user_managed
  replication {
    user_managed {
      # Define replicas blocks dynamically based on the input list
      dynamic "replicas" {
         # Iterate over the locations provided in the variable
         for_each = toset(var.replication_locations)
         # Define a replicas block for each location
         content {
           location = replicas.value # Use the iterator value
         }
      }
    }
  }

  labels = var.labels

  # Optional: Set expiration policy directly as arguments
  expire_time = var.expire_time
  ttl         = var.ttl
}

# Combine the outputs from both resource types
locals {
  all_secrets = merge(
    google_secret_manager_secret.secrets_auto,
    google_secret_manager_secret.secrets_user
  )
}

# Add initial secret versions (if provided)
resource "google_secret_manager_secret_version" "initial_versions" {
  # Iterate over the input values, but reference the combined secrets map
  for_each = { for id, value in var.initial_secret_values : id => value if contains(keys(local.all_secrets), id) }

  secret      = local.all_secrets[each.key].id # Reference the combined map
  secret_data = each.value

  # Ensure version is created after the secret itself
  depends_on = [
    google_secret_manager_secret.secrets_auto,
    google_secret_manager_secret.secrets_user
  ]
}
