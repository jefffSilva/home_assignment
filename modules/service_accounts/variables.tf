# Variables for the simplified Service Accounts module

variable "project_id" {
  description = "The project ID where the service accounts will be created."
  type        = string
}

variable "prefix" {
  description = "A prefix to add to the start of the service account IDs (before the name)."
  type        = string
  default     = "sa-"
}

variable "names" {
  description = "A list of names for the service accounts to create. The final ID will be constructed using the prefix and the name."
  type        = list(string)
  default     = []
}

variable "display_names" {
  description = "A map of service account names (from var.names) to their display names."
  type        = map(string)
  default     = {}
}

variable "descriptions" {
  description = "A map of service account names (from var.names) to their descriptions."
  type        = map(string)
  default     = {}
}

variable "project_roles" {
  description = "A list of project-level IAM roles to grant to all created service accounts (e.g., [\"roles/viewer\"])."
  type        = list(string)
  default     = []
}
