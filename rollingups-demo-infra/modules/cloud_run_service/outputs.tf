output "name" {
  description = "Cloud Run service name"
  value       = google_cloud_run_v2_service.this.name
}

output "url" {
  description = "Cloud Run service url"
  value       = google_cloud_run_v2_service.this.urls[0]
}
