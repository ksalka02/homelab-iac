# resource "kubernetes_service" "api_service_lb" {
#   metadata {
#     name = "${var.app_name}-service-lb"
#   }
#   spec {
#     selector = {
#       app = var.app_name
#     }
#     type = "LoadBalancer"
#     port {
#       port        = var.port_dev
#       target_port = var.port_dev
#       protocol    = "TCP"
#     }
#   }
#   # depends_on = [var.helm_release]
# }

# # Create a local variable for the load balancer name.
# locals {
#   lb_name = split("-", split(".", kubernetes_service.api_service_lb.status.0.load_balancer.0.ingress.0.hostname).0).0
# }

# output "load_balancer_name" {
#   value = local.lb_name
# }

# output "load_balancer_hostname" {
#   value = kubernetes_service.api_service_lb.status.0.load_balancer.0.ingress.0.hostname
# }
