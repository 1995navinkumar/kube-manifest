resource "helm_release" "healthvue" {
  name  = "healthvue"
  chart = path.module
  values = [
    "${file("${path.module}/values.yaml")}"
  ]
}
