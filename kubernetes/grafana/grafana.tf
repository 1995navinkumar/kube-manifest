resource "helm_release" "grafana" {
  name             = "grafana"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "grafana"
  namespace        = "grafana"
  create_namespace = true
  values = [
    "${file("${path.module}/values.yaml")}"
  ]
}

resource "helm_release" "promtail" {
  name       = "promtail"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "promtail"
  namespace  = "grafana"
  values = [
    "${file("${path.module}/promtail-values.yaml")}"
  ]
  depends_on = [helm_release.grafana]
}

resource "helm_release" "loki" {
  name       = "loki"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"
  namespace  = "grafana"
  values = [
    "${file("${path.module}/loki-values.yaml")}"
  ]
  depends_on = [helm_release.grafana]
}

resource "helm_release" "grafana-agent" {
  name       = "grafana-agent"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana-agent"
  namespace  = "grafana"
  values     = ["${file("${path.module}/grafana-agent-values.yaml")}"]
}

resource "kubernetes_manifest" "grafana-agent-ingress" {
  manifest   = yamldecode(file("${path.module}/manifests/grafana-agent-ingress.yaml"))
  depends_on = [helm_release.grafana-agent]
}

resource "kubernetes_manifest" "grafana-faro-svc" {
  manifest   = yamldecode(file("${path.module}/manifests/grafana-faro-svc.yaml"))
  depends_on = [helm_release.grafana-agent]
}

# resource "kubernetes_manifest" "grafana-ingress-middleware" {
#   manifest   = yamldecode(file("${path.module}/manifests/grafana-ingress-middleware.yaml"))
#   depends_on = [helm_release.grafana]
# }

# resource "kubernetes_manifest" "grafana-ingress" {
#   manifest   = yamldecode(file("${path.module}/manifests/grafana-ingress.yaml"))
#   depends_on = [kubernetes_manifest.grafana-ingress-middleware]
# }
