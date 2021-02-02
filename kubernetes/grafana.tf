resource "helm_release" "grafana" {
  name      = "grafana"
  chart     = "grafana/grafana"
  version   = "6.4.7"
  namespace = var.namespace

  values = [
    templatefile("values/grafana.yaml", {
      dashboard_app = indent(8, file("dashboards/app.json"))
    })
  ]
}
