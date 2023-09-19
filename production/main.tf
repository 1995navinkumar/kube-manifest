terraform {
  cloud {
    organization = "sknk"

    workspaces {
      name = "production"
    }
  }
}
