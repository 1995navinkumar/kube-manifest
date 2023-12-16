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
    backoff_limit = 1
    template {
      metadata {
        annotations = {
          scrape_logs = "true"
        }

        labels = {
          app = "run-sql-scripts-job"
        }
      }
      spec {
        restart_policy = "Never"

        container {
          name  = "postgres-client"
          image = "postgres:alpine"

          command = [
            "psql",
            "-h", "postgresql.postgresql",
            "-d", "thirtyinches",
            "-f", "/scripts/thirtyinches_schema.sql",
          ]

          env {
            name  = "PGUSER"
            value = var.postgresUser
          }
          env {
            name  = "PGPASSWORD"
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
  lifecycle {
    replace_triggered_by = [
      kubernetes_config_map.sql_scripts
    ]
  }
}
