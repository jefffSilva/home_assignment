# Root module main configuration

locals {
  # Construct resource names with environment prefix
  resource_prefix = "${var.common_resource_prefix}-${var.environment}"
}

# Enable necessary APIs
module "project_services" {
  source        = "../modules/project_service"
  project_id    = var.project_id
  activate_apis = var.activate_apis
}

# Setup Core Networking
module "core_network" {
  source             = "../modules/core_network"
  project_id         = var.project_id
  project_name       = var.project_id # Assuming project_name is same as id for this module
  region             = var.region
  common_resource_id = local.resource_prefix
  subnets            = var.subnets
  # Add other necessary variables for core_network module based on its variables.tf
  # e.g., nat_external_ips, enable_shared_vpc, etc. - using defaults for now
}

# Setup Cloud Armor Policy
module "cloud_armor" {
  source     = "../modules/cloud_armor"
  project_id = var.project_id
  name       = "${local.resource_prefix}-${var.cloud_armor_policy_name}"
  # Using default OWASP rules as per simplified module
}

# Create Service Account for Cloud Function
module "function_sa" {
  source     = "../modules/service_accounts"
  project_id = var.project_id
  prefix     = "${local.resource_prefix}-"
  names      = [var.function_sa_name]
  project_roles = [
    "roles/run.invoker",                 # Needed for Cloud Functions Gen2
    "roles/secretmanager.secretAccessor" # Example if function needs secrets
  ]
  # Add display_names/descriptions if needed
}

# Create Cloud Function
module "cloud_function" {
  source         = "../modules/cloud_function"
  project_id     = var.project_id
  name           = "${local.resource_prefix}-${var.function_name}"
  region         = var.region
  runtime        = var.function_runtime
  entry_point    = var.function_entry_point
  source_archive = var.function_source_zip
  # Pass the created service account email
  # Note: The cloud_function module needs updating to accept service_account_email
  # service_account_email = module.function_sa.service_account_emails[var.function_sa_name]
  # Add other variables like memory, timeout, env vars as needed
  depends_on = [module.project_services] # Ensure APIs are enabled first
}

# Create Additional Service Accounts (if any)
module "additional_sas" {
  source        = "../modules/service_accounts"
  project_id    = var.project_id
  prefix        = "${local.resource_prefix}-"
  names         = var.service_account_names
  project_roles = var.service_account_project_roles
}

# Create Secrets
module "secrets" {
  source     = "../modules/secret_manager"
  project_id = var.project_id
  secret_ids = var.secret_ids
  replication = "automatic"
  replication_locations  = ["us-central1", "us-east1"]
  # Configure replication, labels, initial values as needed
  depends_on = [module.project_services] # Ensure API is enabled
  labels = {
    env = "prod"
  }

  initial_secret_ids = ["DB_PASSWORD", "API_KEY"]

  initial_secret_values = {
    DB_PASSWORD = "super_secret_password"
    API_KEY     = "key_abc_123"
  }
}

# Note: This root module assumes simplified module interfaces.
# You might need to adjust variable passing based on the exact inputs required by each refactored module.
# Load Balancer configuration is missing and would need to be added, potentially as another module call,
# connecting the Cloud Function and Cloud Armor policy.
