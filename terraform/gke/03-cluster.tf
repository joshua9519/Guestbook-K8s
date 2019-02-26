resource "google_container_cluster" "default" {
  name               = "k1"
  zone               = "europe-west1-b"
  initial_node_count = 3
  network            = "${data.terraform_remote_state.vpc.network.core.self_link}"
  subnetwork         = "${data.terraform_remote_state.vpc.subnet.ew1.self_link}"

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  monitoring_service = "monitoring.googleapis.com/kubernetes"
  logging_service    = "logging.googleapis.com/kubernetes"

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "10.10.10.0/28"
  }

  master_authorized_networks_config {
    cidr_blocks = [
      {
        cidr_block = "194.168.230.101/32"

        display_name = "cts-office"
      },
    ]
  }

  network_policy {
    enabled  = true
    provider = "CALICO"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    machine_type = "n1-standard-1"
  }
}
