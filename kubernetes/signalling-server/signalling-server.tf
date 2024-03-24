resource "helm_release" "signalling-server" {
  name  = "signalling-server"
  chart = path.module
  values = [
    "${file("${path.module}/values.yaml")}"
  ]
}
