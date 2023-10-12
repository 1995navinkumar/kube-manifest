terraform {
  cloud {
    organization = "sknk"

    workspaces {
      name = "terraform"
    }
  }
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.11.0"
    }

  }

}

variable "kubehost" {}

variable "client_certificate" {}

variable "client_key" {}

variable "cluster_ca_certificate" {}

module "kubernetes" {
  source                 = "./kubernetes"
  kubehost               = var.kubehost
  client_certificate     = var.client_certificate
  client_key             = var.client_key
  cluster_ca_certificate = var.cluster_ca_certificate
}
