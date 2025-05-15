resource "google_compute_region_network_endpoint_group" "cloudrun_neg" {
  count                 = var.external_ip != "" ? 1 : 0
  project               = var.project_id
  provider              = google-beta
  name                  = "${var.service_name}-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = google_cloud_run_service.main.name
  }
}

resource "google_compute_backend_service" "default" {
  count = var.external_ip != "" ? 1 : 0
  project = var.project_id
  name  = "${var.service_name}-backend"
  backend {
    group = google_compute_region_network_endpoint_group.cloudrun_neg[count.index].id
  }
  security_policy = var.cloudrun-lb-secure-policy
}
resource "google_compute_url_map" "default" {
  count           = var.external_ip != "" ? 1 : 0
  project         = var.project_id
  name            = "${var.service_name}-urlmap"
  description     = "URL Map for CloudRun-ESPV2-SVC Load Balancer"
  default_service = google_compute_backend_service.default[count.index].id
}
resource "google_compute_target_https_proxy" "default" {
  count = var.external_ip != "" ? 1 : 0
  project         = var.project_id
  name  = "${var.service_name}-https-proxy"

  url_map          = google_compute_url_map.default[count.index].id
  ssl_certificates = local.ssl_certs_uri_list
  ssl_policy       = var.ssl_policy
}
resource "google_compute_global_forwarding_rule" "default" {
  count = var.external_ip != "" ? 1 : 0
  project         = var.project_id
  name  = "${var.service_name}-lb-forwarding-rule"

  target     = google_compute_target_https_proxy.default[count.index].id
  port_range = "443"
  ip_address = var.external_ip
}
