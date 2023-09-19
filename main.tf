terraform {
  cloud {
    organization = "sknk"

    workspaces {
      prefix = "sknk-"
    }
  }
}

module "kubernetes" {
  source = "./kubernetes"
}
