locals {
  ui_name = "ui"
}

resource "kubernetes_service" "ui" {
  metadata {
    name      = local.ui_name
    namespace = var.namespace
    labels = {
      app = local.ui_name
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment.ui.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port        = 9090
      target_port = 9090
      protocol    = "TCP"
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_service_account" "ui" {
  metadata {
    name      = local.ui_name
    namespace = var.namespace
  }
  automount_service_account_token = true
}

resource "kubernetes_deployment" "ui" {
  metadata {
    name      = local.ui_name
    namespace = var.namespace
    labels = {
      app = local.ui_name
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = local.ui_name
      }
    }

    template {
      metadata {
        labels = {
          app = local.ui_name
        }
        annotations = {
          "consul.hashicorp.com/connect-inject"            = "true"
          "consul.hashicorp.com/connect-service-upstreams" = "web:9091"
          "prometheus.io/port"                             = "9102"
          "prometheus.io/scrape"                           = "true"
        }
      }

      spec {
        service_account_name = local.ui_name
        container {
          image = "nicholasjackson/fake-service:v0.19.1"
          name  = local.ui_name

          env {
            name  = "NAME"
            value = "UI"
          }

          env {
            name  = "MESSAGE"
            value = "UI"
          }

          env {
            name  = "UPSTREAM_URIS"
            value = "http://localhost:9091"
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