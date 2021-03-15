resource "google_container_cluster" "primary" {
  name               = var.name
  location           = var.zone
  initial_node_count = 3
  node_config {
    machine_type = "n1-highmem-4"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  timeouts {
    create = "30m"
    update = "40m"
  }
}
