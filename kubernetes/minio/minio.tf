resource "helm_release" "minio" {
  name       = "minio"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "minio"

  values = [
    "${file("${path.module}/values.yaml")}"
  ]
}
