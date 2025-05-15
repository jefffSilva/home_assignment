output "compute_instance" {
  value       = google_compute_instance.compute_instance
  description = "Compute instance"
}

output "ip" {
  value       = google_compute_instance.compute_instance.network_interface.0.network_ip
  description = "The IP address of the compute instance."
}
