resource "helm_release" "healthvue-server" {
  name  = "healthvue-server"
  chart = path.module
  values = [
    "${file("${path.module}/values.yaml")}"
  ]
}
