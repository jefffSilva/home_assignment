module "hello_function" {
  source = "../modules/cloud_function"
  project_id             = var.project_id
  name                   = var.function_name
  region                 = var.region
  description            = "My first Cloud Function"
  entry_point            = "helloWorld"
  runtime                = "python311"
  source_archive         = var.source_archive
  memory                 = "256Mi"
  timeout                = 60
  max_instances          = 2
  environment_variables  = {
    ENV = "dev"
  }
}

resource "google_compute_region_network_endpoint_group" "function_neg" {
  project               = var.project_id
  name                  = "${module.hello_function.name}-neg"
  region                = var.region
  network_endpoint_type = "SERVERLESS"

  cloud_function {
    function = module.hello_function.function_name
  }
}

resource "google_compute_backend_service" "function_backend" {
  project               = var.project_id  
  name                  = "${module.hello_function.name}-backend"
  protocol              = "HTTP"
  load_balancing_scheme = "EXTERNAL"

  backend {
    group = google_compute_region_network_endpoint_group.function_neg.id
  }
}

resource "google_compute_url_map" "function_url_map" {
  project               = var.project_id
  name            = "${module.hello_function.name}-url-map"
  default_service = google_compute_backend_service.function_backend.id
}

resource "google_compute_target_http_proxy" "function_http_proxy" {
  project               = var.project_id  
  name    = "${module.hello_function.name}-http-proxy"
  url_map = google_compute_url_map.function_url_map.id
}

resource "google_compute_global_address" "lb_ip" {
  project               = var.project_id  
  name = "${module.hello_function.name}-ip"
}

resource "google_compute_global_forwarding_rule" "function_forwarding_rule" {
  project               = var.project_id
  name                  = "${module.hello_function.name}-fwd-rule"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  target                = google_compute_target_http_proxy.function_http_proxy.id
  ip_protocol           = "TCP"
  ip_address            = google_compute_global_address.lb_ip.address
}

resource "google_cloudfunctions2_function_iam_member" "invoker" {
  project        = var.project_id
  location       = var.region
  cloud_function = module.hello_function.function_name
  role           = "roles/cloudfunctions.invoker"
  member         = "allUsers"
}
