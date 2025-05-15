locals {
  service_list_set = toset(var.service_list)

  service_identity_set = toset(var.service_identity_list)

  project_org_id    = var.folder_id != "" ? null : var.org_id
  project_folder_id = var.folder_id != "" ? var.folder_id : null
  
}