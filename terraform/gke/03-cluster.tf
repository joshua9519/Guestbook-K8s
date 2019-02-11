resource "google_container_cluster" "default" {
  name               = "k1"
  zone               = "europe-west1-b"
  initial_node_count = 2

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  network_policy {
    enabled  = true
    provider = "CALICO"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    machine_type = "n1-standard-1"
  }
}
