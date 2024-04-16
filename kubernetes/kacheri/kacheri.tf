resource "helm_release" "kacheri" {
  name  = "kacheri"
  chart = path.module
  values = [
    "${file("${path.module}/values.yaml")}"
  ]
}
