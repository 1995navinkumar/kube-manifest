resource "kubernetes_manifest" "db-storage" {
  manifest = yamldecode(file("${path.module}/manifests/db-storage.yaml"))
}

resource "kubernetes_manifest" "monitoring-storage" {
  manifest = yamldecode(file("${path.module}/manifests/monitoring-storage.yaml"))
}
