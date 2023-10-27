resource "kubernetes_manifest" "local-storage-class" {
  manifest = yamldecode(file("${path.module}/manifests/local-storage-class.yaml"))
}
resource "kubernetes_manifest" "persistent-volume-3_1" {
  manifest = yamldecode(file("${path.module}/manifests/persistent-volume-3_1.yaml"))
}
