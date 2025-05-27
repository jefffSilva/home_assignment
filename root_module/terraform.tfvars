# Example terraform.tfvars for the root module
# Define common variables or leave placeholders to be overridden by environment-specific files.

# General Settings
project_id = "your-gcp-project-id" # REQUIRED: Replace with your GCP project ID
region     = "us-central1"         # Default region, can be overridden
environment = "dev"                # Default environment, override in env files

# Network Configuration (Example - adjust as needed)
network_name = "main-vpc"
subnets = [
  {
    name = "subnet-us-central1"
    cidr = "10.10.10.0/24"
    region = "us-central1"
  }
]
activate_apis = [
  "compute.googleapis.com",
  "storage.googleapis.com",
  "cloudfunctions.googleapis.com",
  "secretmanager.googleapis.com",
  "run.googleapis.com", # Added Run API for Cloud Functions Gen2 dependencies
  "artifactregistry.googleapis.com", # Added Artifact Registry for Cloud Functions Gen2
  "cloudbuild.googleapis.com", # Added Cloud Build for Cloud Functions Gen2
  "iam.googleapis.com",
  "logging.googleapis.com",
  "monitoring.googleapis.com",
  "servicenetworking.googleapis.com"
]

# Cloud Function Configuration
function_name        = "hello-world-function"
function_runtime     = "python311"
function_entry_point = "hello_http" # Assuming entry point based on common examples
function_source_zip  = "../src/hello-world.zip"

# Service Account Configuration
sa_names = ["cloud-function-sa"]

# Secret Manager Configuration
secret_ids = ["my-app-secret"]

# Cloud Armor Configuration
cloud_armor_policy_name = "default-armor-policy"
