resource "kubernetes_deployment" "api_deployment" {
  metadata {
    name = "api-deployment"
    labels = {
      app = var.app_name
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        # image_pull_secrets {
        #   name = kubernetes_secret.ecr_key.metadata.0.name
        # }

        container {
          name              = "nba-player-guesser-api"
          image             = "939365853055.dkr.ecr.us-east-1.amazonaws.com/nba-player-guesser-api:master"
          image_pull_policy = "Always"

          env_from {
            config_map_ref {
              name = kubernetes_config_map.api_configmap.metadata.0.name
            }
          }

          # env_from {
          #   secret_ref {
          #     name = kubernetes_secret.aws_secret.metadata.0.name
          #   }
          # }

          # env_from {
          #   secret_ref {
          #     name = kubernetes_secret.ecr_key.metadata.0.name
          #   }
          # }

          port {
            container_port = var.port_dev
          }
        }
        container {
          name              = "redis"
          image             = "redis:7.0.15-alpine"
          image_pull_policy = "Always"
          port {
            container_port = 6379
          }
        }
      }
    }
  }
}
