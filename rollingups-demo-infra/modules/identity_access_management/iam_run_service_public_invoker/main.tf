resource "google_cloud_run_service_iam_member" "public_invoker" {
    for_each    = toset(var.services)
    project     = var.project_id
    location    = var.location
    service     = each.value
    role        = "roles/run.invoker"
    member      = "allUsers"
}
