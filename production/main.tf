terraform {
  cloud {
    organization = "sknk"

    workspaces {
      name = "production"
    }
  }
}

module "kubernetes" {
  source = "/kubernetes"
}
