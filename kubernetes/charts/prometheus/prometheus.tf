resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-community/prometheus"

  values = [
    "${file("${path.module}/values.yaml")}"
  ]
}
