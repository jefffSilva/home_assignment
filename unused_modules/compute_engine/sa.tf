locals {
  roles_list_set = toset(var.roles_list)
 
}



resource "google_service_account" "instance" {
    
  project  = var.project_id
  account_id = var.sa
}


resource "google_project_iam_member" "sa_role" {
  for_each = local.roles_list_set

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.instance.email}"
}

