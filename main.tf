terraform {
  cloud {
    organization = "sknk"

    workspaces {
      tags = ["terraform"]
    }
  }
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.11.0"
    }
  }

  kubernetes {
    host = var.kube-host

    client_certificate     = var.client_certificate
    client_key             = var.client_key
    cluster_ca_certificate = var.cluster_ca_certificate
  }
}

module "kubernetes" {
  source = "./kubernetes"
}
