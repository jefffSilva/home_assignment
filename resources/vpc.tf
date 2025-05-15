module "network" {
  source             = "../modules/core_network"
  project_id         = var.project_id
  project_name       = var.project_id
  region             = var.region
  common_resource_id = var.common_resource_id
  subnets            = var.subnets_list
  nat_external_ips   = var.nat_external_ips
}
resource "google_compute_global_address" "private-service-connection" {
  project       = var.project_id
  name          = "psconnect-ip"
  address_type  = "INTERNAL"
  purpose       = "VPC_PEERING"
  prefix_length = 24
  network       = module.network.vpc_network.id
  address       = var.private_service_connection_address
}

resource "google_service_networking_connection" "private_service_connection" {
  network                 = module.network.vpc_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private-service-connection.name]
}