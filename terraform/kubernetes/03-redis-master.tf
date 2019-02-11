resource "kubernetes_deployment" "redis-master" {
  metadata {
    name = "redis-master"

    labels {
      app = "redis"
    }
  }

  spec {
    selector {
      match_labels {
        app  = "redis"
        role = "master"
        tier = "backend"
      }
    }

    replicas = 1

    template {
      metadata {
        labels {
          app  = "redis"
          role = "master"
          tier = "backend"
        }
      }

      spec {
        container {
          name  = "master"
          image = "k8s.gcr.io/redis:e2e"

          resources {
            requests {
              cpu    = "100m"
              memory = "100Mi"
            }
          }

          port {
            container_port = 6379
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "redis-master" {
  metadata {
    name = "redis-master"

    labels {
      app  = "redis"
      role = "master"
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
      role = "master"
      tier = "backend"
    }
  }
}
