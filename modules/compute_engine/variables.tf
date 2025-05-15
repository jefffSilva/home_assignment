

variable "total_local_ssd_disks" {
  type        = number
  default     = 0
  description = "Local ssd nvme disk."
}
variable "iap-users" {
  description = <<-EOT
    List of IAM members who are granted the "roles/iap.tunnelResourceAccessor" role. 
    This can include users, groups, users or  service accounts

    Examples:
      - Group: "group:developers@zazmic.com"
      - Service Account: "serviceAccount:my-service-account@zazmic.iam.gserviceaccount.com"
  EOT

  type = list
}

variable "create_boot_disk" {
  type    = bool
  default = false
}
variable "create_data_disk" {
  type    = bool
  default = false
}

variable metadata_startup_script{
  description = "metadata_startup_script"
  type = string
}

variable "static_ip_address" {
  type        = string
  description = "The static IP address to assign to the instance."
  default     = null # Make it optional
}

variable zone{
  description = "zone"
  type = string
}

variable sa{
  description = "sa name"
  type = string
}



variable compute_image_id{
  description = "compute img"
  type = string
}
variable disk_size{
  description = "compute disk size"
  type = string
}


variable machine_type{
  description = "machine type"
  type = string
}

variable project_id{
  description = "project_id"
  type = string
}


variable "network_tags" {
  type = list(string)
  description = "Network tags"
  default = []
}

variable "instance_name" {
  type = string
  description = "Instance Name"
}


variable "subnet" {
  type = string
  description = "Subnet"
}



variable "subnetwork_project" {
  type = string
  description = "Subnet"
}

variable "data_disk_require" {
  type = bool
  default = false
}


variable "metadata" {
  type = map
  default = {
    enable-oslogin = "TRUE"
    block-project-ssh-keys= "TRUE"
  }
}


variable "enable_secure_boot" {
  type = bool
  default = false
}
variable "enable_integrity_monitoring" {
  type = bool
  default = false
}
variable "deletion_protection" {
  type = bool
  default = false
}
variable "enable_vtpm" {
  type = bool
  default = false
}


variable "roles_list" {
  type    = list(string)
  default = []
}

