resource "helm_release" "coturn" {
  name       = "coturn"
  repository = "https://charts.jaconi.io"
  chart      = "coturn"

  values = [
    "${file("${path.module}/values.yaml")}"
  ]
}