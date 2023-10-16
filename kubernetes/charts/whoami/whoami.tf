resource "helm_release" "whoami" {
  name       = "whoami"
  chart      = "./"
}