resource "helm_release" "prometheus" {
  name      = "prometheus"
  chart     = "prometheus-community/prometheus"
  version   = "13.4.0"
  namespace = var.namespace

  values = [
    file("values/prometheus.yaml")
  ]
}
