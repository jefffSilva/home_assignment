variable "secret_ids" {
  description = "List of secret names to be created"
  type        = list(string)
}

variable "replication" {
  description = "Replication type: automatic or user_managed"
  type        = string
}

variable "replication_locations" {
  description = "Locations for user-managed secrets"
  type        = list(string)
  default     = []
}

variable "project_id" {
  type = string
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "expire_time" {
  type    = string
  default = null
}

variable "ttl" {
  type    = string
  default = null
}

variable "initial_secret_ids" {
  description = "List of secret IDs that should have initial versions created"
  type        = list(string)  # 🚫 DO NOT mark as sensitive
}

variable "initial_secret_values" {
  description = "Map of secret values"
  type        = map(string)
  sensitive   = true
}
