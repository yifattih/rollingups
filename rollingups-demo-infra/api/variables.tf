variable "project_id" {
  description = "The ID of the project"
  type        = string
  sensitive   = false
  validation {
    condition     = length(var.project_id) > 0
    error_message = "The project ID must not be empty"
  }
}

variable "location" {
  description = "The region where resources will be deployed"
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

variable "ingress_image" {
  description = "Container image for the Cloud Run service"
  type        = string
  default     = null
  sensitive   = false
  #   validation {
  #     condition     = var.ingress_image == null || length(var.ingress_image) > 0
  #     error_message = "If provided, the container image must not be empty"
  #   }
}

variable "ingress_port" {
  description = "Port for the Cloud Run service"
  type        = number
  default     = 8080
  sensitive   = false
  validation {
    condition     = var.ingress_port > 0 && var.ingress_port < 65536
    error_message = "The port must be between 1 and 65535"
  }
}

variable "ingress_env_vars" {
  description = "Environment variables for the ingress container"
  type        = list(object({ name = string, value = string }))
  default     = []
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
