resource "helm_release" "minio" {
  name             = "s3"
  namespace        = "storage"
  create_namespace = true
  chart            = "minio/minio"
  version          = "8.0.10"

  values = [
    file("values/minio.yaml")
  ]
}


