# Root module variables

variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "region" {
  description = "The primary GCP region for resources."
  type        = string
  default     = "us-central1"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, qa, prod)."
  type        = string
}

variable "common_resource_prefix" {
  description = "A common prefix to use for naming resources, often including the environment."
  type        = string
  default     = "tf-proj"
}

# Network Variables
variable "network_name" {
  description = "Name for the VPC network."
  type        = string
  default     = "main-vpc"
}

variable "subnets" {
  description = "List of subnets to create."
  type = list(object({
    name   = string
    cidr   = string
    region = string
  }))
  default = []
}

variable "activate_apis" {
  description = "List of Google APIs to enable on the project."
  type        = list(string)
  default     = []
}

# Cloud Function Variables
variable "function_name" {
  description = "Name for the Cloud Function."
  type        = string
}

variable "function_runtime" {
  description = "Runtime for the Cloud Function (e.g., python311)."
  type        = string
}

variable "function_entry_point" {
  description = "Entry point function within the source code."
  type        = string
}

variable "function_source_zip" {
  description = "Path to the zipped source code for the Cloud Function."
  type        = string
}

variable "function_sa_name" {
  description = "Name of the service account to create for the Cloud Function."
  type        = string
  default     = "cloud-function-sa"
}

# Service Account Variables
variable "service_account_names" {
  description = "List of additional service account names to create."
  type        = list(string)
  default     = []
}

variable "service_account_project_roles" {
  description = "List of project-level roles to grant to additional service accounts."
  type        = list(string)
  default     = []
}

# Secret Manager Variables
variable "secret_ids" {
  description = "List of secret IDs to create in Secret Manager."
  type        = list(string)
  default     = []
}

# Secret Manager Variables
variable "sa_names" {
  description = "List of secret names to create in Secret Manager."
  type        = list(string)
  default     = []
}
# Cloud Armor Variables
variable "cloud_armor_policy_name" {
  description = "Name for the Cloud Armor security policy."
  type        = string
  default     = "default-armor-policy"
}

