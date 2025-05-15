output "enabled_services" {
  description = "List of enabled service APIs"
  value       = [for service in local.service_list_set : service]
}

output "service_identities" {
  description = "Map of enabled service identities"
  value       = { for identity in google_project_service_identity.service_identity : identity.service => identity.email }
}
output "project_id" {
  description = "Project where services were enabled"
  value       = var.project_id
}