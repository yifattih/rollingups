resource "google_storage_bucket_object" "this" {
  name    = "${var.prefix}/.keep"
  bucket  = var.bucket_name
  content = "Placeholder to ensure the folder exists. Do not delete, reserved by Terraform."

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [content]
  }
}
