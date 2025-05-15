variable "service_list" {
  type    = list(string)
  default = ["iam.googleapis.com","compute.googleapis.com" ,"cloudresourcemanager.googleapis.com","container.googleapis.com","secretmanager.googleapis.com", "servicenetworking.googleapis.com"]
}

variable "project_id" {
  type    = string
}

variable "project_name" {
  type = string
}

variable "org_id" {
  type    = string
  default     = null
}

variable "folder_id" {
  type    = string
  default     = ""

}

variable "service_identity_list" {
  type    = list(string)
  default = []
}
variable "billing_account" {
  type    = string
  default = null
}