resource "helm_release" "traefik" {
  name       = "traefik"
  repository = "https://traefik.github.io/charts"
  chart      = "traefik"

  values = [
    "${file("${path.module}/values.yaml")}"
  ]
}