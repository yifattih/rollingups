module "admin_sa" {
  source       = "../modules/service_account"
  description  = "Service account for managing Cloud Run"
  account_id   = "${var.service_name}-admin-sa"
  display_name = "Cloud Run Admin Service Account for ${var.service_name}"
  project_id   = var.project_id
}

module "admin_sa_roles" {
  source                = "../modules/identity_access_management/iam_service_account_roles"
  project_id            = var.project_id
  service_account_email = module.admin_sa.email
  roles = [
    "roles/run.developer",
    "roles/artifactregistry.reader",
    "roles/iam.serviceAccountUser",
    "roles/iam.serviceAccountTokenCreator",
    "roles/storage.objectAdmin"
  ]
  depends_on = [module.admin_sa]
}

module "cloud_run_service" {
  source                = "../modules/cloud_run_service"
  project_id            = var.project_id
  location              = var.location
  service_name          = var.service_name
  ingress_setting       = "INGRESS_TRAFFIC_ALL"
  revision_name         = var.revision_name
  service_account_email = module.admin_sa.email
  ingress_image         = var.ingress_image
  ingress_port          = var.ingress_port
  ingress_env_vars      = var.ingress_env_vars
  release_strategy      = var.release_strategy
  stable_revision       = var.stable_revision
  depends_on            = [module.admin_sa_roles]
}

module "public_invoker" {
  source     = "../modules/identity_access_management/iam_run_service_public_invoker"
  project_id = var.project_id
  location   = var.location
  services = [
    module.cloud_run_service.name
  ]
  depends_on = [module.cloud_run_service]
}

# module "private_invoker" {
#   source     = "../modules/identity_access_management/iam_run_service_private_invoker"
#   project_id = var.project_id
#   location   = var.location
#   services = [
#     module.cloud_run_service.name
#   ]
#   service_account = module.admin_sa.email
# }
