resource "kubernetes_manifest" "local-storage-class" {
  manifest = yamldecode(file("${path.module}/manifests/local-storage-class.yaml"))
}
resource "kubernetes_manifest" "persistent-volume-3_1" {
  manifest = yamldecode(file("${path.module}/manifests/persistent-volume-3Gi.yaml"))
}

resource "kubernetes_manifest" "persistent-volume-3_2" {
  manifest = yamldecode(file("${path.module}/manifests/persistent-volume-3Gi.yaml"))
}

resource "kubernetes_manifest" "persistent-volume-3_3" {
  manifest = yamldecode(file("${path.module}/manifests/persistent-volume-3Gi.yaml"))
}
