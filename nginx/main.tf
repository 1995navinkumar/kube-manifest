resource "kubernetes_manifest" "nginx" {
  manifest = yamldecode(file("${path.module}/deployment.yml"))
}
