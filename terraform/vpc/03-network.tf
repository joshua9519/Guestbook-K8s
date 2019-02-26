resource "google_compute_network" "core" {
  name                    = "core"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "ew1" {
  name          = "europe-west1"
  region        = "europe-west1"
  network       = "${google_compute_network.core.self_link}"
  ip_cidr_range = "10.0.0.0/20"

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.0.16.0/20"
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.0.32.0/20"
  }
}
