# Root module outputs

output "cloud_function_uri" {
  description = "The HTTPS URI of the deployed Cloud Function (requires appropriate IAM permissions for invocation)."
  value       = module.cloud_function.function_uri
}

output "cloud_function_sa_email" {
  description = "Email of the service account created for the Cloud Function."
  value       = module.function_sa.service_account_emails[var.function_sa_name]
}

output "network_name" {
  description = "Name of the VPC network created."
  value       = module.core_network.vpc_network.name
}

output "subnet_names" {
  description = "Names of the subnets created."
  value       = [for s in module.core_network.subnets : s.name]
}

output "cloud_armor_policy_id" {
  description = "The ID of the Cloud Armor security policy created."
  value       = module.cloud_armor.policy.id
}

output "secret_names" {
  description = "Full names of the secrets created in Secret Manager."
  value       = module.secrets.secret_names
}
