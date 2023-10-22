resource "helm_release" "prometheus" {
  name             = "prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "prometheus"
  namespace        = "monitoring"
  create_namespace = true

  values = [
    "${file("${path.module}/prometheus-values.yaml")}"
  ]
}

resource "kubernetes_manifest" "prometheus-ingress" {
  manifest = yamldecode(file("${path.module}/manifests/ingress.yaml"))
}
