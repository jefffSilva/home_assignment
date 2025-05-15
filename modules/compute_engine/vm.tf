resource "google_project_service" "iap_api" {
  project                   = var.project_id
  service                   = "iap.googleapis.com"
  disable_on_destroy        = false
}

resource "google_compute_instance" "compute_instance" {
  project                   = var.project_id
  name                      = var.instance_name
  machine_type              = var.machine_type
  zone                      = var.zone
  tags                      = var.network_tags
  metadata_startup_script   = var.metadata_startup_script
  

  metadata = var.metadata

  boot_disk {
    initialize_params {
      image = var.compute_image_id
      size  = var.disk_size
    }
  }
  dynamic "scratch_disk" {
    for_each = range(var.total_local_ssd_disks)
    content {
      interface = "NVME"
    }
  }

  
  allow_stopping_for_update = true

  service_account {
    email  = google_service_account.instance.email
    scopes = ["cloud-platform"]
  }
  
   network_interface {
    subnetwork = var.subnet
    subnetwork_project= var.subnetwork_project
    access_config {
      nat_ip = var.static_ip_address != null ? var.static_ip_address : null
    }
    
  }

   shielded_instance_config {
   enable_secure_boot          = var.enable_secure_boot
   enable_integrity_monitoring = var.enable_integrity_monitoring
   enable_vtpm = var.enable_vtpm
  }
  deletion_protection = var.deletion_protection
  
}

