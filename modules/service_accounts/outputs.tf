# Outputs for the simplified Service Accounts module

output "service_account_emails" {
  description = "Map of service account names to their email addresses."
  value = {
    for name, sa in google_service_account.service_accounts :
    name => sa.email
  }
}

output "service_account_ids" {
  description = "Map of service account names to their unique IDs."
  value = {
    for name, sa in google_service_account.service_accounts :
    name => sa.id
  }
}

output "service_account_names" {
  description = "Map of service account names to their fully qualified names."
  value = {
    for name, sa in google_service_account.service_accounts :
    name => sa.name
  }
}
