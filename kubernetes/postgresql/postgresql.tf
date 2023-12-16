resource "helm_release" "postgresql" {
  name             = "postgresql"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "postgresql"
  namespace        = "postgresql"
  create_namespace = true
  values = [
    templatefile("${path.module}/values.yaml", {
      postgresAdminPassword = var.postgresAdminPassword,
      postgresUser          = var.postgresUser,
      postgresPassword      = var.postgresPassword
    })
  ]
}

resource "kubernetes_config_map" "sql_scripts" {
  metadata {
    name      = "sql_scripts"
    namespace = "postgresql"
  }

  data = {
    "thirtyinches_schema.sql" = "${file("${path.module}/scripts/thirtyinches/schema.sql")}"
  }

}
