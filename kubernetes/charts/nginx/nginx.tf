resource "helm_release" "nginx" {
  name = "nginx"

  repository = "oci://registry-1.docker.io/bitnamicharts/nginx"
  chart      = "nginx"
}
