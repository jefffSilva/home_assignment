
module "folder" {
  for_each = { for folders in var.folders_details : folders.parent_id => folders }
  source   = "../modules/google_folder"
  parent   = each.value.parent_id
  names    = each.value.folders_names
}

module "project" {
  for_each        = { for projects in var.projects_details : projects.project_id => projects }
  source          = "../modules/project_service"
  project_name    = each.value.name
  project_id      = each.value.project_id
  folder_id       = each.value.folder_id
  billing_account = each.value.billing_account
  service_list    = each.value.service_list
}

