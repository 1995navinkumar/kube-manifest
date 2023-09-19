provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "nginx" {
  source = "./charts/nginx"
}