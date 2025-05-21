variable "project_id" {
  description = "GCP Project ID"
  type        = string
  sensitive   = false
  validation {
    condition     = length(var.project_id) > 0
    error_message = "The GCP Project ID must not be empty"
  }
}

variable "location" {
  description = "GCP region for the service"
  type        = string
  sensitive   = false
  validation {
    condition     = length(var.location) > 0
    error_message = "The location must not be empty"
  }
}

variable "service_name" {
  description = "Name of the Cloud Run service"
  type        = string
  default     = null
  sensitive   = false
  validation {
    condition     = length(var.service_name) > 0
    error_message = "The Cloud Run service name must not be empty"
  }
}

variable "ingress_setting" {
  description = "value"
  type        = string
  default     = "INGRESS_TRAFFIC_INTERNAL_ONLY"
  sensitive   = false
}

variable "revision_name" {
  description = "Name of the revision"
  type        = string
  default     = null
  sensitive   = false
  #   validation {
  #     condition     = var.revision_name == null || length(var.revision_name) > 0
  #     error_message = "If provided, the revision name must not be empty"
  #   }
}

variable "execution_environment" {
  description = "Execution environment (EXECUTION_ENVIRONMENT_GEN1 or EXECUTION_ENVIRONMENT_GEN2)"
  type        = string
  sensitive   = false
  default     = "EXECUTION_ENVIRONMENT_GEN2"
}

variable "service_account_email" {
  description = "Service account email for the Cloud Run service"
  type        = string
  default     = null
  sensitive   = false
  validation {
    condition     = var.service_account_email == null || length(var.service_account_email) > 0
    error_message = "If provided, the service account email must not be empty"
  }
}

variable "cpu_throttling" {
  description = "Enable or disable CPU throttling (true or false)"
  type        = string
  sensitive   = false
  default     = "true"
}

variable "ingress_image" {
  description = "Docker image for the ingress container"
  type        = string
  default     = null
  sensitive   = false
  #   validation {
  #     condition     = var.ingress_image == null || length(var.ingress_image) > 0
  #     error_message = "The ingress image must not be empty"
  #   }
}

variable "ingress_port" {
  description = "Port for the ingress container"
  type        = number
  default     = 8000
}

variable "ingress_cpu" {
  description = "CPU limit for the ingress container"
  type        = string
  default     = "1"
}

variable "ingress_memory" {
  description = "Memory limit for the ingress container"
  type        = string
  default     = "512Mi"
}

variable "ingress_env_vars" {
  description = "Environment variables for the ingress container"
  type        = list(object({ name = string, value = string }))
  default     = []
}

variable "min_instances" {
  description = "Minimum number of instances"
  type        = number
  default     = 0
}

variable "max_instances" {
  description = "Maximum number of instances"
  type        = number
  default     = 2
}

variable "max_requests_per_container" {
  description = "Maximum number of concurrent requests per container"
  type        = number
  default     = 80
}

variable "request_timeout" {
  description = "Request timeout in seconds"
  type        = number
  default     = 300
}

variable "release_strategy" {
  description = "Release strategy for the service (first_deploy, canary, promote, rollback)"
  type        = string
  default     = "first_deploy"
  sensitive   = false
  validation {
    condition     = contains(["first_deploy", "canary", "full_rollout", "rollback"], var.release_strategy)
    error_message = "The release strategy must be: first_deploy | canary | full_rollout | rollback"
  }
}

variable "stable_revision" {
  description = "Stable revision name for canary deployment or rollback"
  type        = string
  default     = null
}
