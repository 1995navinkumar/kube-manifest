resource "helm_release" "react-starter-vite" {
  name  = "react-starter-vite"
  chart = path.module
}
