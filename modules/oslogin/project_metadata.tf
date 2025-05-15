resource "google_compute_project_metadata_item" "oslogin" {
  project = var.project_id
  key     = "enable-oslogin"
  value   = "TRUE"
}