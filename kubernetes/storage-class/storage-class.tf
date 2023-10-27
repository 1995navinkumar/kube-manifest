resource "kubernetes_manifest" "local-storage-class" {
  manifest = yamldecode(file("${path.module}/manifests/local-storage-class.yaml"))
}
