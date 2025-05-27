##########################
# Locals
##########################

locals {
  # Ensure secret_ids is a set for safe iteration
  secret_ids_set = toset(var.secret_ids)

  # Create maps for secrets based on replication type
  automatic_secrets = {
    for id in local.secret_ids_set : id => id
    if var.replication == "automatic"
  }

  user_managed_secrets = {
    for id in local.secret_ids_set : id => id
    if var.replication == "user_managed"
  }

  # Combine the outputs from both resource types
  all_secrets = merge(
    google_secret_manager_secret.secrets_auto,
    google_secret_manager_secret.secrets_user
  )
}

##########################
# Secrets (AUTOMATIC replication)
##########################

resource "google_secret_manager_secret" "secrets_auto" {
  for_each = local.automatic_secrets

  project   = var.project_id
  secret_id = each.value

  replication {
    auto {}
  }

  labels       = var.labels
  expire_time  = var.expire_time
  ttl          = var.ttl
}

##########################
# Secrets (USER_MANAGED replication)
##########################

resource "google_secret_manager_secret" "secrets_user" {
  for_each = local.user_managed_secrets

  project   = var.project_id
  secret_id = each.value

  replication {
    user_managed {
      dynamic "replicas" {
        for_each = toset(var.replication_locations)
        content {
          location = replicas.value
        }
      }
    }
  }

  labels       = var.labels
  expire_time  = var.expire_time
  ttl          = var.ttl
}

##########################
# Secret Versions (Initial Values)
##########################

resource "google_secret_manager_secret_version" "initial_versions" {
  for_each = {
    for id in var.initial_secret_ids :  # ⚠️ You must pass this input separately and it must NOT be marked sensitive
    id => id
    if contains(keys(google_secret_manager_secret.secrets_auto), id)
      || contains(keys(google_secret_manager_secret.secrets_user), id)
  }

  secret      = try(
    google_secret_manager_secret.secrets_auto[each.key].id,
    google_secret_manager_secret.secrets_user[each.key].id
  )

  secret_data = var.initial_secret_values[each.key]

  depends_on = [
    google_secret_manager_secret.secrets_auto,
    google_secret_manager_secret.secrets_user
  ]
}
