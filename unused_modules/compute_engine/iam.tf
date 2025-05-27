resource "google_iap_tunnel_instance_iam_binding" "binding" {
  project = var.project_id
  zone = google_compute_instance.compute_instance.zone
  instance = google_compute_instance.compute_instance.name
  role = "roles/iap.tunnelResourceAccessor"
  members = var.iap-users
}