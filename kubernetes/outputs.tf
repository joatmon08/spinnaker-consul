output "ui_endpoint" {
  value = var.consul_is_available ? "http://${module.app.0.load_balancer_ip}:9090" : ""
}

output "grafana_yaml" {
  value = templatefile("values/grafana.yaml", {
    dashboard_app = indent(8, file("dashboards/app.json"))
  })
}