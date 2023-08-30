resource "kubernetes_deployment" "nginx" {
  manifest = yamldecode(file("./deployment.yml"))
}
