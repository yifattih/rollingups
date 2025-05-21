variable "description" {
    description = "A detailed description of the service account"
    type        = string
    default     = null
    validation {
        condition     = length(var.description) > 0
        error_message = "The description must not be empty."
    }
}

variable "account_id" {
    description = "The account ID of the service account"
    type        = string
    default     = null
    validation {
        condition     = length(var.account_id) > 0
        error_message = "The account ID must not be empty."
    }
}

variable "display_name" {
    description = "A user-friendly name for the service account"
    type        = string
    default     = null
    validation {
        condition     = length(var.display_name) > 0
        error_message = "The display name must not be empty."
    }
}

variable "project_id" {
    description = "The ID of the project where the service account will be created"
    type        = string
    default     = null
    validation {
        condition     = length(var.project_id) > 0
        error_message = "The project ID must not be empty."
    }  
}
