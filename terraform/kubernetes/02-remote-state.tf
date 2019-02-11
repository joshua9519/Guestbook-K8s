data "terraform_remote_state" "gke" {
  backend = "gcs"

  config {
    bucket = "${var.project_id}-nonprod-tfstate"
    prefix = "gke"
  }
}
