variable "project_id" {
  description = "The project ID where the secrets will be created."
  type        = string
}

variable "secret_ids" {
  description = "A list of secret IDs to create."
  type        = list(string)
  default     = []
}

variable "replication" {
  description = "Replication policy for the secrets. Allowed values: \"automatic\", \"user_managed\"."
  type        = string
  default     = "automatic"
  validation {
    condition     = contains(["automatic", "user_managed"], var.replication)
    error_message = "Allowed values for replication are: automatic, user_managed."
  }
}

variable "replication_locations" {
  description = "A list of locations for user-managed replication. Required if replication is \"user_managed\"."
  type        = list(string)
  default     = []
}

variable "labels" {
  description = "A map of labels to add to the secrets."
  type        = map(string)
  default     = {}
}

variable "initial_secret_values" {
  description = "A map of secret IDs to their initial secret data (string). Use with caution for sensitive data."
  type        = map(string)
  default     = {}
  sensitive   = true
}

# Optional rotation settings
variable "rotation_period" {
  description = "The rotation period for the secret (e.g., \"86400s\"). If set, rotation is enabled."
  type        = string
  default     = null
}

variable "rotation_next_time" {
  description = "Timestamp in RFC3339 UTC \"Zulu\" format for the next rotation time. Required if rotation_period is set."
  type        = string
  default     = null
}

variable "rotation_topics" {
  description = "List of Pub/Sub topic names for rotation notifications."
  type        = list(string)
  default     = []
}

# Optional expiration settings (choose one: expire_time or ttl)
variable "expire_time" {
  description = "Timestamp in RFC3339 UTC \"Zulu\" format for when the secret should expire."
  type        = string
  default     = null
}

variable "ttl" {
  description = "The TTL for the secret (e.g., \"86400s\")."
  type        = string
  default     = null
}
