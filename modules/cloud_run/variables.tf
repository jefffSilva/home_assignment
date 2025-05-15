
locals {
  prefix             = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/global/sslCertificates"
  ssl_certs_uri_list = [for cert in var.ssl_certs_list : "${local.prefix}/${cert}"]
}
variable sa{
  description = "sa name"
  type = string
  default = "cloudrun"
}

// service
variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
}
variable "service_name" {
  description = "The name of the Cloud Run service to create"
  type        = string
}

variable "no_auth" {
  type    = bool
  default = false
}

variable "connector_name" {
  description = "The name of the Cloud Run service to create"
  type        = string
  default     = "cloud-run"
}

variable "ip_cidr_range" {
  description = "The name of the Cloud Run service to create"
  type        = string
  default     = ""
}
variable "network_name" {
  description = "The name of the Cloud Run service to create"
  type        = string
  default     = ""
}

variable "location" {
  description = "Cloud Run service deployment location"
  type        = string
}
variable "region" {
  description = "region"
  type        = string
}
variable "ssl_policy" {
  description = "SslPolicy that will be associated with the TargetHttpsProxy"
  type        = string
  default     = ""
}
variable "cloudrun-lb-secure-policy" {
  type    = string
  default = ""
}
variable "image" {
  description = "GCR hosted image URL to deploy"
  type        = string
}

variable "generate_revision_name" {
  type        = bool
  description = "Option to enable revision name generation"
  default     = true
}

variable "traffic_split" {
  type = list(object({
    latest_revision = bool
    percent         = number
    revision_name   = string
  }))
  description = "Managing traffic routing to the service"
  default = [{
    latest_revision = true
    percent         = 100
    revision_name   = "v1-0-0"
  }]
}

variable "service_labels" {
  type        = map(string)
  description = "A set of key/value label pairs to assign to the service"
  default     = {}
}

variable "service_annotations" {
  type        = map(string)
  description = "Annotations to the service. Acceptable values all, internal, internal-and-cloud-load-balancing"
  default     = null
}

// Metadata
variable "template_labels" {
  type        = map(string)
  description = "A set of key/value label pairs to assign to the container metadata"
  default     = {}
}

variable "template_annotations" {
  type        = map(string)
  description = "Annotations to the container metadata including VPC Connector and SQL. See [more details](https://cloud.google.com/run/docs/reference/rpc/google.cloud.run.v1#revisiontemplate)"
  default     = null
}

variable "encryption_key" {
  description = "CMEK encryption key self-link expected in the format projects/PROJECT/locations/LOCATION/keyRings/KEY-RING/cryptoKeys/CRYPTO-KEY."
  type        = string
  default     = null
}

// template spec
variable "container_concurrency" {
  type        = number
  description = "Concurrent request limits to the service"
  default     = null
}

variable "timeout_seconds" {
  type        = number
  description = "Timeout for each request"
  default     = 120
}
variable "service_account_email" {
  type        = string
  description = "Service Account email needed for the service"
  default     = ""
}

variable "volumes" {
  type = list(object({
    name = string
    secret = set(object({
      secret_name = string
      items       = map(string)
    }))
  }))
  description = "[Beta] Volumes needed for environment variables (when using secret)"
  default     = []
}


variable "startup_probe_enabled" {
  description = "Enable the statup probe"
  default     = false
}
variable "startup_probe_type" {
  type        = string
  description = "Type of probe to deploy"
  default     = "tcp_socket"
}
variable "failure_threshold" {
  type    = number
  default = 10
}
variable "initial_delay_seconds" {
  type    = number
  default = 10
}
variable "period_seconds" {
  type    = number
  default = 10
}
variable "probe_timeout_seconds" {
  type    = number
  default = 10
}
variable "startup_probe_port" {
  type    = number
  default = 3000
}

variable "limits" {
  type        = map(string)
  description = "Resource limits to the container"
  default     = null
}
variable "requests" {
  type        = map(string)
  description = "Resource requests to the container"
  default     = {}
}

variable "ports" {
  type = object({
    name = string
    port = number
  })
  description = "Port which the container listens to (http1 or h2c)"
  default = {
    name = "http1"
    port = 8080
  }
}

variable "argument" {
  type        = list(string)
  description = "Arguments passed to the ENTRYPOINT command, include these only if image entrypoint needs arguments"
  default     = []
}

variable "container_command" {
  type        = list(string)
  description = "Leave blank to use the ENTRYPOINT command defined in the container image, include these only if image entrypoint should be overwritten"
  default     = []
}

variable "env_vars" {
  type = list(object({
    value = string
    name  = string
  }))
  description = "Environment variables (cleartext)"
  default     = []
}

variable "env_secret_vars" {
  type = list(object({
    name = string
    value_from = set(object({
      secret_key_ref = map(string)
    }))
  }))
  description = "[Beta] Environment variables (Secret Manager)"
  default     = []
}

variable "volume_mounts" {
  type = list(object({
    mount_path = string
    name       = string
  }))
  description = "[Beta] Volume Mounts to be attached to the container (when using secret)"
  default     = []
}

// IAM
variable "members" {
  type        = list(string)
  description = "Users/SAs to be given invoker access to the service"
  default     = []
}


variable "ssl_certs_list" {
  type        = list(string)
  description = "List of sssl CERTS uri"
  default     = []
}

variable "external_ip" {
  type    = string
  default = ""
}

