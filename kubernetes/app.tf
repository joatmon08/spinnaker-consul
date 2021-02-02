module "app" {
  count     = var.consul_is_available ? 1 : 0
  source    = "./modules/apps"
  namespace = var.namespace
}