resource "google_storage_bucket" "function_source" {
  project       = var.project_id  
  name          = "${var.name}-source-${random_id.suffix.hex}"
  location      = var.region
  force_destroy = true
  uniform_bucket_level_access = true
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "google_storage_bucket_object" "function_zip" {
  name    = "${var.name}.zip"
  bucket  = google_storage_bucket.function_source.name
  source  = var.source_archive
  
}

resource "google_cloudfunctions2_function" "function" {
  name        = var.name
  project     = var.project_id
  location    = var.region
  description = var.description

  build_config {
    runtime     = var.runtime
    entry_point = var.entry_point
    source {
      storage_source {
        bucket = google_storage_bucket.function_source.name
        object = google_storage_bucket_object.function_zip.name
      }
    }
  }

  service_config {
    max_instance_count    = var.max_instances
    available_memory      = var.memory
    timeout_seconds       = var.timeout
    environment_variables = var.environment_variables
  }

  depends_on = [google_storage_bucket_object.function_zip]
}
