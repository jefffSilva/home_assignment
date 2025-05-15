resource "google_project_service_identity" "service_identity" {
  for_each = local.service_identity_set

  provider = google-beta
  project  = var.project_id
  service  = each.value
}