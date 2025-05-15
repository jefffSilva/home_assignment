
variable "project_id" {
  type        = string
  description = "The GCP project ID"
  default     = ""
}

variable "folders_details" {
  type = list(object({
    parent_id     = string,
    folders_names = list(string)
  }))
  default     = []
  description = "description"
}
variable "sub_folders" {
  type = list(object({
    parent_folder_name = string,
    folder_name        = string
  }))
  default     = []
  description = "description"
}

variable "projects_details" {
  type = list(object({
    name            = string,
    project_id      = string,
    folder_name     = optional(string),
    folder_id       = optional(string),
    billing_account = string,
    service_list    = optional(list(string)),
  }))
  default     = []
  description = "description"

}