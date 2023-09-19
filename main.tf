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
}

module "kubernetes" {
  source = "./kubernetes"
}
