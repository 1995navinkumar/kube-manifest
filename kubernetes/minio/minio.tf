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

resource "kubernetes_manifest" "minio-ingress-middleware" {
  manifest   = yamldecode(file("${path.module}/manifests/minio-ingress-middleware.yaml"))
  depends_on = [helm_release.minio]
}

resource "kubernetes_manifest" "minio-ingress" {
  manifest   = yamldecode(file("${path.module}/manifests/minio-ingress.yaml"))
  depends_on = [kubernetes_manifest.minio-ingress-middleware]
}
