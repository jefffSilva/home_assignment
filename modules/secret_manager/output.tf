# Outputs for the Secret Manager module

output "secret_ids" {
  description = "The IDs of the created secrets."
  value = concat(
    [for s in google_secret_manager_secret.secrets_auto : s.secret_id],
    [for s in google_secret_manager_secret.secrets_user : s.secret_id]
  )
}

output "secret_names" {
  description = "The full names of the created secrets."
  value = concat(
    [for s in google_secret_manager_secret.secrets_auto : s.name],
    [for s in google_secret_manager_secret.secrets_user : s.name]
  )
}

output "initial_version_ids" {
  description = "Map of secret IDs to their initial version IDs (if created)."
  value = {
    for id, v in google_secret_manager_secret_version.initial_versions :
    id => v.id
  }
}
