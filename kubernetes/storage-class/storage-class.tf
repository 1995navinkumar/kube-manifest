resource "kubernetes_manifest" "db-storage" {
  manifest = yamldecode(file("${path.module}/manifests/db-storage.yaml"))
}

resource "kubernetes_manifest" "log-storage" {
  manifest = yamldecode(file("${path.module}/manifests/log-storage.yaml"))
}
