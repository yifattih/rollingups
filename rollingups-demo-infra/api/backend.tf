terraform {
  backend "gcs" {
    bucket = "rollingups"
    prefix = "api/terraform"
  }
}
