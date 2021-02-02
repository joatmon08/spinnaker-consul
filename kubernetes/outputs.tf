output "ui_endpoint" {
  value = var.consul_is_available ? "http://${module.app.0.load_balancer_ip}:9090" : ""
}