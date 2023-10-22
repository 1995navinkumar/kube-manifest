provider "helm" {
  kubernetes {

    host = var.kubehost

    client_certificate     = base64decode(var.client_certificate)
    client_key             = base64decode(var.client_key)
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host = var.kubehost

  client_certificate     = base64decode(var.client_certificate)
  client_key             = base64decode(var.client_key)
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

# module "nginx" {
#   source = "./charts/nginx"
# }

# module "traefik" {
#   source = "./charts/traefik"
# }

module "whoami" {
  source = "./charts/whoami"
}

module "react-starter-vite" {
  source = "./charts/react-starter-vite"
}

module "test-server" {
  source = "./charts/test-server"
}
module "prometheus" {
  source = "./charts/prometheus"
}
