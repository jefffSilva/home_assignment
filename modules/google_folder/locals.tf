locals {
  prefix = var.prefix == "" ? "" : "${var.prefix}-"
  folders_list = [for name in var.names : try(google_folder.folders[name], "")]
  first_folder = try(local.folders_list[0], {})
}
