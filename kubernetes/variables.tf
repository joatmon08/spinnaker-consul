variable "consul_helm_version" {
  type        = string
  description = "version of Consul Helm chart"
  default     = "0.30.0"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace"
  default     = "default"
}

variable "consul_is_available" {
  type        = bool
  description = "toggle to create applications when Consul is available"
  default     = false
}