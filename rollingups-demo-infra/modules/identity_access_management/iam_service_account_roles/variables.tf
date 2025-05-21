variable "project_id" {
  description = "The project ID where roles should be assigned"
  type        = string
}

variable "service_account_email" {
  description = "The email of the service account"
  type        = string
}

variable "roles" {
  description = "The IAM role to assign"
  type        = list(string)
}
