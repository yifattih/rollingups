output "path" {
  description = "The full GCS path"
  value       = "gs://${google_storage_bucket_object.this.bucket}/${var.prefix}"
}
