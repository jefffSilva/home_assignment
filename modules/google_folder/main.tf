resource "google_folder" "folders" {
  for_each = toset(var.names)

  display_name = "${local.prefix}${each.value}"
  parent       = var.parent
}
