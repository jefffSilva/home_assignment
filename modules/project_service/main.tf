# Main configuration for the Project Service module

# Enable specified APIs on the project
resource "google_project_service" "activated_apis" {
  # Use the input variable directly, converted to a set
  for_each = toset(var.activate_apis)

  project                    = var.project_id
  service                    = each.value
  disable_on_destroy         = var.disable_services_on_destroy
  disable_dependent_services = var.disable_dependent_services

  # Removed depends_on = [ google_project.project ] as project creation is out of scope
}
