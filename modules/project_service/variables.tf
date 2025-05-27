# Variables for the Project Service module

variable "project_id" {
  description = "The project ID where the APIs will be activated."
  type        = string
}

variable "activate_apis" {
  description = "A list of APIs to activate on the project (e.g., [\"compute.googleapis.com\", \"storage.googleapis.com\"])."
  type        = list(string)
  default     = []
}

variable "disable_services_on_destroy" {
  description = "Whether to disable APIs when the resource is destroyed."
  type        = bool
  default     = false # Recommended to keep false to avoid accidental disruption
}

variable "disable_dependent_services" {
  description = "If `true`, services that are enabled and which depend on this service should also be disabled when this service is destroyed. If `false` or unset, an error will be generated if any enabled services depend on this service when destroying it."
  type        = bool
  default     = true
}
