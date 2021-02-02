locals {
  web_name = "web"
}

resource "kubernetes_service" "web" {
  metadata {
    name      = local.web_name
    namespace = var.namespace
    labels = {
      app = local.web_name
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment.web.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port        = 9090
      target_port = 9090
      protocol    = "TCP"
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_service_account" "web" {
  metadata {
    name      = local.web_name
    namespace = var.namespace
  }
  automount_service_account_token = true
}

resource "kubernetes_deployment" "web" {
  metadata {
    name      = local.web_name
    namespace = var.namespace
    labels = {
      app     = local.web_name
      release = "baseline"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = local.web_name
      }
    }

    template {
      metadata {
        labels = {
          app = local.web_name
        }
        annotations = {
          "consul.hashicorp.com/connect-inject"       = "true"
          "consul.hashicorp.com/service-meta-version" = "baseline"
          "prometheus.io/port"                        = "9102"
          "prometheus.io/scrape"                      = "true"
        }
      }

      spec {
        service_account_name = local.web_name
        container {
          image = "nicholasjackson/fake-service:v0.19.1"
          name  = local.web_name

          env {
            name  = "NAME"
            value = "Web (baseline)"
          }

          env {
            name  = "MESSAGE"
            value = "Web (baseline)"
          }

          port {
            container_port = 9090
            protocol       = "TCP"
          }

          liveness_probe {
            http_get {
              path = "/health"
              port = 9090
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}