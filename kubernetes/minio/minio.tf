resource "kubernetes_manifest" "minio-namespace" {
  manifest = yamldecode(file("${path.module}/manifests/minio-namespace.yaml"))
}
resource "helm_release" "minio" {
  name       = "minio"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "minio"

  values = [
    "${file("${path.module}/values.yaml")}"
  ]
  depends_on = [kubernetes_manifest.minio-namespace]
}
