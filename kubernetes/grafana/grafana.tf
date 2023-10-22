resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"

  values = [
    "${file("${path.module}/values.yaml")}"
  ]
}
