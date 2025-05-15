output "service_name" {
  value       = google_cloud_run_service.main.name
  description = "Name of the created service"
}

output "revision" {
  value       = google_cloud_run_service.main.status[0].latest_ready_revision_name
  description = "Deployed revision for the service"
}

output "service_url" {
  value       = google_cloud_run_service.main.status[0].url
  description = "The URL on which the deployed service is available"
}

output "project_id" {
  value       = google_cloud_run_service.main.project
  description = "Google Cloud project in which the service was created"
}

output "location" {
  value       = google_cloud_run_service.main.location
  description = "Location in which the Cloud Run service was created"
}

output "service_id" {
  value       = google_cloud_run_service.main.id
  description = "Unique Identifier for the created service"
}

output "service_status" {
  value       = google_cloud_run_service.main.status[0].conditions[0].type
  description = "Status of the created service"
}

//load-balancing
output "backend_services" {
  description = "The backend service resources."
  value       = google_compute_backend_service.default
  sensitive   = true // can contain sensitive iap_config
}
output "https_proxy" {
  description = "The HTTPS proxy used by this module."
  value       = google_compute_target_https_proxy.default[*].self_link
}
output "url_map" {
  description = "The default URL map used by this module."
  value       = google_compute_url_map.default[*].self_link
}
