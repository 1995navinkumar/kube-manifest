provider "helm" {
  kubernetes {

    host = var.kubehost

    client_certificate     = var.client_certificate
    client_key             = var.client_key
    cluster_ca_certificate = var.cluster_ca_certificate
  }
}
module "nginx" {
  source = "./charts/nginx"
}
