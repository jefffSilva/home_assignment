variable "name" {
  description = "Name of the Cloud Function"
  type        = string
}

variable "region" {
  description = "Region for the function"
  type        = string
  default     = "us-central1"
}

variable "description" {
  description = "Description of the function"
  type        = string
  default     = ""
}

variable "entry_point" {
  description = "Name of the entry point function"
  type        = string
}

variable "runtime" {
  description = "Runtime (e.g., python311, nodejs20)"
  type        = string
}

variable "source_archive" {
  description = "Path to the zipped function source code"
  type        = string
}

variable "memory" {
  description = "Memory to allocate (e.g., 256Mi)"
  type        = string
  default     = "256Mi"
}

variable "timeout" {
  description = "Function timeout in seconds"
  type        = number
  default     = 60
}

variable "max_instances" {
  description = "Max number of function instances"
  type        = number
  default     = 1
}

variable "environment_variables" {
  description = "Map of environment variables"
  type        = map(string)
  default     = {}
}
variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
}