resource "kubernetes_manifest" "prometheus-namespace" {
  manifest = yamldecode(file("${path.module}/manifests/prometheus-namespace.yaml"))
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  values = [
    "${file("${path.module}/prometheus-values.yaml")}"
  ]
  depends_on = [kubernetes_manifest.prometheus-namespace]
}

resource "kubernetes_manifest" "prometheus-ingress-middleware" {
  manifest   = yamldecode(file("${path.module}/manifests/prometheus-ingress-middleware.yaml"))
  depends_on = [helm_release.prometheus]
}

resource "kubernetes_manifest" "prometheus-ingress" {
  manifest   = yamldecode(file("${path.module}/manifests/prometheus-ingress.yaml"))
  depends_on = [kubernetes_manifest.prometheus-ingress-middleware]
}
