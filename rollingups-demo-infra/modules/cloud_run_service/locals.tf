locals {
  traffic_config = (
    var.release_strategy == "rollback" ? [
      {
        type     = "TRAFFIC_TARGET_ALLOCATION_TYPE_REVISION"
        revision = var.stable_revision
        percent  = 100
      }
    ] :
    var.release_strategy == "canary" ? [
      {
        type     = "TRAFFIC_TARGET_ALLOCATION_TYPE_REVISION"
        revision = var.stable_revision
        percent  = 90
      },
      {
        type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
        percent = 10
      }
    ] :
    #  first_deploy and full_rollout handled together
    [
      {
        type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
        percent = 100
      }
    ]
  )
}
