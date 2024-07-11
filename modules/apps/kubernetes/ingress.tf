# resource "kubernetes_ingress_v1" "api_ingress" {
#   wait_for_load_balancer = true
#   metadata {
#     name = "${var.app_name}-ingress"
#   }

#   spec {
#     ingress_class_name = "nginx"
#     rule {
#       host = "${var.app_name}.com"

#       http {
#         path {
#           path      = "/player/generate"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = kubernetes_service.api_service_lb.metadata.0.name
#               port {
#                 number = var.port_dev
#               }
#             }
#           }
#         }
#         path {
#           path      = "/player/guess"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = kubernetes_service.api_service_lb.metadata.0.name
#               port {
#                 number = var.port_dev
#               }
#             }
#           }
#         }
#         path {
#           path      = "/user/score"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = kubernetes_service.api_service_lb.metadata.0.name
#               port {
#                 number = var.port_dev
#               }
#             }
#           }
#         }
#         path {
#           path      = "/user/update"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = kubernetes_service.api_service_lb.metadata.0.name
#               port {
#                 number = var.port_dev
#               }
#             }
#           }
#         }
#         path {
#           path      = "/user/delete"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = kubernetes_service.api_service_lb.metadata.0.name
#               port {
#                 number = var.port_dev
#               }
#             }
#           }
#         }
#       }
#     }

#   }
# }

# # Display load balancer hostname (typically present in AWS)
# output "load_balancer_hostname" {
#   value = kubernetes_ingress_v1.api_ingress.status.0.load_balancer.0.ingress.0.hostname
# }

# # Display load balancer IP (typically present in GCP, or using Nginx ingress controller)
# output "load_balancer_ip" {
#   value = kubernetes_ingress_v1.api_ingress.status.0.load_balancer.0.ingress.0.ip
# }

# # resource "kubernetes_ingress" "players_ingress" {
# #   metadata {
# #     name = "players-ingress"
# #   }

# #   spec {
# #     # backend {
# #     #   service_name = "players-service-lb"
# #     #   service_port = 5000
# #     # }

# #     rule {
# #       host = "players.com"
# #       http {
# #         path {
# #           path = "/players"

# #           backend {
# #             service_name = kubernetes_service.players_service_lb.id
# #             service_port = 5000
# #           }
# #         }
# #       }
# #     }
# #   }
# # }


################################################
################################################
# ALB INGRESS
################################################
################################################




# resource "kubernetes_ingress_v1" "api_ingress" {
#   wait_for_load_balancer = true
#   metadata {
#     name = "${var.app_name}-ingress"
#     labels = {
#       app = "nba-player-guesser"
#     }
#     annotations = {
#       # ingress core settings:
#       "kubernetes.io/ingress.class"      = "alb"
#       "alb.ingress.kubernetes.io/scheme" = "internet-facing"
#       # ingress health check:
#       "alb.ingress.kubernetes.io/healthcheck-protocol"         = "HTTP"
#       "alb.ingress.kubernetes.io/healthcheck-port"             = "traffic-port"
#       "alb.ingress.kubernetes.io/healthcheck-path"             = "/ping"
#       "alb.ingress.kubernetes.io/healthcheck-interval-seconds" = "15"
#       "alb.ingress.kubernetes.io/healthcheck-timeout-seconds"  = "5"
#       "alb.ingress.kubernetes.io/success-codes"                = "200"
#       "alb.ingress.kubernetes.io/healthy-threshold-count"      = "2"
#       "alb.ingress.kubernetes.io/unhealthy-threshold-count"    = "2"
#     }
#   }

#   spec {
#     # ingress_class_name = "nginx"
#     rule {
#       host = "${var.app_name}.com"

#       http {
#         path {
#           path      = "/player/generate"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = kubernetes_service.api_service_lb.metadata.0.name
#               port {
#                 number = var.port_dev
#               }
#             }
#           }
#         }
#         path {
#           path      = "/player/guess"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = kubernetes_service.api_service_lb.metadata.0.name
#               port {
#                 number = var.port_dev
#               }
#             }
#           }
#         }
#         path {
#           path      = "/user/score"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = kubernetes_service.api_service_lb.metadata.0.name
#               port {
#                 number = var.port_dev
#               }
#             }
#           }
#         }
#         path {
#           path      = "/user/update"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = kubernetes_service.api_service_lb.metadata.0.name
#               port {
#                 number = var.port_dev
#               }
#             }
#           }
#         }
#         path {
#           path      = "/user/delete"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = kubernetes_service.api_service_lb.metadata.0.name
#               port {
#                 number = var.port_dev
#               }
#             }
#           }
#         }
#       }
#     }

#   }
# }

# # Display load balancer hostname (typically present in AWS)
# output "load_balancer_hostname" {
#   value = kubernetes_ingress_v1.api_ingress.status.0.load_balancer.0.ingress.0.hostname
# }

# # Display load balancer IP (typically present in GCP, or using Nginx ingress controller)
# output "load_balancer_ip" {
#   value = kubernetes_ingress_v1.api_ingress.status.0.load_balancer.0.ingress.0.ip
# }
