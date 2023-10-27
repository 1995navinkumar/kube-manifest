resource "kubernetes_manifest" "local-storage-class" {
  manifest = yamldecode(file("${path.module}/manifests/local-storage-class.yaml"))
}
resource "kubernetes_manifest" "persistent-volume-3Gi_1" {
  manifest = yamldecode(file("${path.module}/manifests/persistent-volume-3gi-1.yaml"))
}

resource "kubernetes_manifest" "persistent-volume-3Gi_2" {
  manifest = yamldecode(file("${path.module}/manifests/persistent-volume-3gi-2.yaml"))
}

resource "kubernetes_manifest" "persistent-volume-3Gi_3" {
  manifest = yamldecode(file("${path.module}/manifests/persistent-volume-3gi-3.yaml"))
}
