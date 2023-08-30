resource "kubernetes_manifest" "nginx" {
  manifest = yamldecode(file("./deployment.yml"))
}
