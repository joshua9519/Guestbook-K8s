output "network.core.self_link" {
  value = "${google_compute_network.core.self_link}"
}

output "subnet.ew1.self_link" {
  value = "${google_compute_subnetwork.ew1.self_link}"
}
