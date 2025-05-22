resource "google_cloud_run_v2_service" "this" {
  project             = var.project_id
  location            = var.location
  name                = var.service_name
  ingress             = var.ingress_setting
  launch_stage        = "BETA"
  description         = "Cloud Run service for ${var.service_name}"
  deletion_protection = false # set to true in production to prevent destruction of the resource
  template {
    service_account                  = var.service_account_email
    revision                         = var.revision_name
    execution_environment            = var.execution_environment
    timeout                          = "${var.request_timeout}s"
    max_instance_request_concurrency = var.max_requests_per_container
    scaling {
      min_instance_count = var.min_instances
      max_instance_count = var.max_instances
    }
    containers {
      name  = "ingress"
      image = var.ingress_image
      ports {
        name           = "http1"
        container_port = var.ingress_port
      }
      dynamic "env" {
        for_each = var.ingress_env_vars
        content {
          name  = env.value["name"]
          value = env.value["value"]
        }
      }
      resources {
        limits = {
          cpu    = var.ingress_cpu
          memory = var.ingress_memory
        }
        cpu_idle = true
      }
    }
  }
  # dynamically generate one traffic block per element in local.traffic_config
  dynamic "traffic" {
    for_each = local.traffic_config
    content {
      type     = traffic.value.type
      revision = lookup(traffic.value, "revision", null)
      percent  = traffic.value.percent
      tag      = lookup(traffic.value, "tag", null)
    }
  }
}
