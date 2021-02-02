resource "kubernetes_manifest" "consul_proxy_defaults" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "consul.hashicorp.com/v1alpha1"
    "kind"       = "ProxyDefaults"
    "metadata" = {
      "name"      = "global"
      "namespace" = var.namespace
    }
    "spec" = {
      "config" = {
        "envoy_prometheus_bind_addr" = "0.0.0.0:9102"
        "protocol"                   = "http"
      }
    }
  }
}