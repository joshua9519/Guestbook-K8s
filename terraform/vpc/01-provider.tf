provider "google" {
  version = "2.0.0" // See https://www.terraform.io/docs/configuration/terraform.html#specifying-a-required-terraform-version for version constraint syntax

  project = "${var.project_id}" // GCP Project ID
  region  = "${var.region}"     // Default GCP Region
}
