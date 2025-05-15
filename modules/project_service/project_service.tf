resource "google_project_service" "service" {
  for_each = local.service_list_set
  
  project    = var.project_id 
  service    = each.value
  disable_on_destroy = false
  disable_dependent_services = true
  depends_on = [ google_project.project ]

}
