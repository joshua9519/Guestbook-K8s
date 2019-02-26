output "lb-ip" {
  value = "${kubernetes_service.frontend.load_balancer_ingress.0.ip}"
}
