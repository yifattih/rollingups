variable "bucket_name" {
  description = "The name of the GCS bucket where the prefix will be created."
  type        = string
}

variable "prefix" {
  description = "The folder-like path within the bucket to protect (e.g. deployment_metadata/)"
  type        = string
}
