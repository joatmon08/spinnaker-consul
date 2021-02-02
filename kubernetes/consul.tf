resource "helm_release" "consul" {
  name      = "consul"
  chart     = "https://github.com/hashicorp/consul-helm/archive/v${var.consul_helm_version}.tar.gz"
  namespace = var.namespace

  values = [
    file("values/consul.yaml")
  ]
}

