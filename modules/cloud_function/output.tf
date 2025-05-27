# Outputs for the Cloud Function module

output "function_id" {
  description = "The fully qualified ID of the function"
  value       = google_cloudfunctions2_function.function.id
}

output "function_name" {
  description = "The name of the function"
  value       = google_cloudfunctions2_function.function.name
}

output "function_uri" {
  description = "The URI of the function (if applicable, requires enabling invocation)"
  value       = google_cloudfunctions2_function.function.service_config[0].uri
}

output "source_bucket_name" {
  description = "The name of the bucket storing the function source code"
  value       = google_storage_bucket.function_source.name
}

output "source_object_name" {
  description = "The name of the source code object in the bucket"
  value       = google_storage_bucket_object.function_zip.name
}
