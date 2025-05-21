variable "project_id" {
  description = "The project ID where roles should be assigned"
  type        = string
}

variable "location" {
    description = "The location of the Cloud Run service"
    type        = string
}

variable "services" {
    description = "Parent resource to bind the IAM policy to"
    type        = list(string)  
}

variable "service_account" {
    description = "The service account to which the IAM policy will be applied"
    type = string
}