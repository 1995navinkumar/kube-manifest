resource "helm_release" "test-server" {
  name  = "test-server"
  chart = path.module
  values = [
    "${file("${path.module}/values.yaml")}"
  ]
}
