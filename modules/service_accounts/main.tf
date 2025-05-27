# Simplified Service Accounts Module

locals {
  # Ensure names is a set for safe iteration
  account_names = toset(var.names)

  # Create a flattened list of objects, each representing a sa_name/role pair
  sa_role_pairs = flatten([
    for sa_name in local.account_names : [
      for role in toset(var.project_roles) : {
        sa_name = sa_name
        role    = role
        key     = "${sa_name}-${role}" # Unique key for the map
      }
    ]
  ])

  # Convert the list of objects into a map suitable for for_each
  project_roles_map = {
    for pair in local.sa_role_pairs : pair.key => pair
  }
}

# Create service accounts
resource "google_service_account" "service_accounts" {
  for_each     = local.account_names
  project      = var.project_id
  # Ensure account_id is within length limits (6-30 chars)
  # Using substr to truncate if necessary. Consider a more robust naming strategy if collisions are likely.
  account_id   = substr("${var.prefix}${lower(each.value)}", 0, 30)
  display_name = coalesce(var.display_names[each.value], "Terraform-managed SA: ${each.value}")
  description  = coalesce(var.descriptions[each.value], "Managed by Terraform")
}

# Grant project-level roles to the service accounts
resource "google_project_iam_member" "project_roles" {
  for_each = local.project_roles_map

  project = var.project_id
  role    = each.value.role
  member  = "serviceAccount:${google_service_account.service_accounts[each.value.sa_name].email}"

  # Ensure IAM binding happens after SA creation
  depends_on = [google_service_account.service_accounts]
}
