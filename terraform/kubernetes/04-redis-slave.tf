resource "kubernetes_deployment" "redis-slave" {
  metadata {
    name = "redis-slave"

    labels {
      app = "redis"
    }
  }

  spec {
    selector {
      match_labels {
        app  = "redis"
        role = "slave"
        tier = "backend"
      }
    }

    replicas = 2

    template {
      metadata {
        labels {
          app  = "redis"
          role = "slave"
          tier = "backend"
        }
      }

      spec {
        container {
          name  = "slave"
          image = "gcr.io/google_samples/gb-redisslave:v1"

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
            container_port = 6379
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "redis-slave" {
  metadata {
    name = "redis-slave"

    labels {
      app  = "redis"
      role = "slave"
      tier = "backend"
    }
  }

  spec {
    port {
      port        = 6379
      target_port = 6379
    }

    selector {
      app  = "redis"
      role = "slave"
      tier = "backend"
    }
  }
}
