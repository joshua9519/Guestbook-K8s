resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "frontend"

    labels {
      app = "guestbook"
    }
  }

  spec {
    selector {
      match_labels {
        app  = "guestbook"
        tier = "frontend"
      }
    }

    replicas = 3

    template {
      metadata {
        labels {
          app  = "guestbook"
          tier = "frontend"
        }
      }

      spec {
        container {
          name  = "php-redis"
          image = "gcr.io/google-samples/gb-frontend:v4"

          resources {
            requests {
              cpu    = "100m"
              memory = "100Mi"
            }
          }

          env {
            name  = "GET_HOSTS_FROM"
            value = "dns"
          }

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "frontend" {
  metadata {
    name = "frontend"

    labels {
      app  = "guestbook"
      tier = "frontend"
    }
  }

  spec {
    port {
      port = 80
    }

    type = "LoadBalancer"

    selector {
      app  = "guestbook"
      tier = "frontend"
    }
  }
}
