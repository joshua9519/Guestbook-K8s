resource "kubernetes_storage_class" "gce-pd" {
  metadata {
    name = "regional-pd"
  }

  storage_provisioner = "kubernetes.io/gce-pd"

  parameters {
    type             = "pd-standard"
    replication-type = "regional-pd"
  }
}

resource "kubernetes_persistent_volume_claim" "jenkins-data" {
  metadata {
    name = "jenkins-data"
  }

  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = "${kubernetes_storage_class.gce-pd.metadata.0.name}"

    resources {
      requests {
        storage = "50Gi"
      }
    }
  }
}

resource "kubernetes_deployment" "jenkins" {
  metadata {
    name = "jenkins"

    labels {
      app = "jenkins"
    }
  }

  spec {
    selector {
      match_labels {
        app = "jenkins"
      }
    }

    replicas = 1

    template {
      metadata {
        labels {
          app = "jenkins"
        }
      }

      spec {
        container {
          name  = "jenkins"
          image = "docker.io/jenkins/jenkins:lts"

          env {
            name  = "GET_HOSTS_FROM"
            value = "dns"
          }

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "jenkins" {
  metadata {
    name = "jenkins"

    labels {
      app = "jenkins"
    }
  }

  spec {
    port {
      port = 8080
    }

    type = "LoadBalancer"

    selector {
      app = "jenkins"
    }
  }
}
