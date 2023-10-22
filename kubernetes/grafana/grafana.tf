resource "kubernetes_manifest" "grafana-namespace" {
  manifest = yamldecode(file("${path.module}/manifests/grafana-namespace.yaml"))
}
resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"

  values = [
    "${file("${path.module}/values.yaml")}"
  ]
  depends_on = [kubernetes_manifest.grafana-namespace]
}

# resource "kubernetes_manifest" "grafana-ingress-middleware" {
#   manifest   = yamldecode(file("${path.module}/manifests/grafana-ingress-middleware.yaml"))
#   depends_on = [helm_release.grafana]
# }

# resource "kubernetes_manifest" "grafana-ingress" {
#   manifest   = yamldecode(file("${path.module}/manifests/grafana-ingress.yaml"))
#   depends_on = [kubernetes_manifest.grafana-ingress-middleware]
# }
