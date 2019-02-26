data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config {
    prefix = "vpc"
    bucket = "${var.project_id}-${var.envname}-tfstate"
  }
}
