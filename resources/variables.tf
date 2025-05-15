########################################
# General Project Variables
########################################
variable "project_id" {
  type        = string
  default     = ""
  description = "description"
}
variable "common_resource_id" {
  type        = string
  default     = "nw"
  description = "description"
}
variable "region" {
  type = string

}

########################################
# Networking (VPC, Subnets, NAT)
########################################
variable "subnets_list" {
  type = list(object({
    name      = string
    cidr      = string
    region    = optional(string)
    allow_nat = optional(bool)
    secondary_ip_range = optional(list(object({ range_name = string
      ip_cidr_range = string
    })))
  }))
  default     = []
  description = "List of subnet objects"
}
variable "nat_external_ips" {
  type = list(object({
    name        = string
    description = string
    region      = string
  }))
  default = []
}
variable "private_service_connection_address" {
  type    = string
  default = ""
}

########################################
# CloudRun,VPC Connector, load balancer
########################################

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
variable "sa" {
  description = "sa name"
  type        = string
  default     = "cloudrun"
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

##### Firewall rules

variable "ssh_ingress_ranges" {
  description = "Ranges to allow SSH ingress from."
  type        = list(string)
  default     = []
}

variable "ssh_ingress_protocol" {
  description = "Protocol for SSH ingress."
  type        = string
  default     = ""
}

variable "ssh_ingress_ports" {
  description = "Ports for SSH ingress."
  type        = list(string)
  default     = []
}

variable "vpc_name" {
  description = "VPC Netowrk name"
  type        = string
  default     = ""
}

variable "function_name" {
  description = "Name of the Cloud Function"
  type        = string
}

variable "source_archive" {
  description = "Path to the zipped function source code"
  type        = string
}
