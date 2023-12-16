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
    name      = "sql-scripts"
    namespace = "postgresql"
  }

  data = {
    "thirtyinches_schema.sql" = "${file("${path.module}/scripts/thirtyinches/schema.sql")}"
  }

}

resource "kubernetes_job" "run_sql_scripts" {
  metadata {
    name      = "run-sql-scripts"
    namespace = "postgresql"
  }

  spec {
    template {
      metadata {

      }
      spec {
        restart_policy = "Never"

        container {
          name  = "postgres-client"
          image = "jbergknoff/postgresql-client"

          command = [
            "psql",
            "-h", "localhost",
            "-d", "thirtyinches",
            "-f", "/scripts/thirtyinches_schema.sql",
          ]

          env {
            name  = "POSTGRES_USER"
            value = var.postgresUser
          }
          env {
            name  = "POSTGRES_PASSWORD"
            value = var.postgresPassword
          }


          volume_mount {
            name       = "sql-scripts-volume"
            mount_path = "/scripts"
          }
        }

        volume {
          name = "sql-scripts-volume"
          config_map {
            name = "sql-scripts"
          }
        }
      }
    }
  }

  depends_on = [
    helm_release.postgresql, kubernetes_config_map.sql_scripts
  ]
}
