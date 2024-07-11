resource "kubernetes_service" "api_service_lb" {
  metadata {
    name = "${var.app_name}-service-lb"
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type"            = "external"
      "service.beta.kubernetes.io/aws-load-balancer-nlb-target-type" = "ip"
      "service.beta.kubernetes.io/aws-load-balancer-scheme"          = "internet-facing"
      # "service.beta.kubernetes.io/aws-load-balancer-proxy-protocol"  = "*"
      # "service.beta.kubernetes.io/aws-load-balancer-extra-security-groups" = aws_security_group.api_lb_sg.id
      #
      #
      #
      # "service.beta.kubernetes.io/aws-load-balancer-healthcheck-healthy-threshold" = "2" # The number of successive successful health checks required for a backend to be considered healthy for traffic. Defaults to 2, must be between 2 and 10

      # "service.beta.kubernetes.io/aws-load-balancer-healthcheck-unhealthy-threshold" = "10"
      # # The number of unsuccessful health checks required for a backend to be considered unhealthy for traffic. Defaults to 6, must be between 2 and 10

      # "service.beta.kubernetes.io/aws-load-balancer-healthcheck-interval" = "50"
      # # The approximate interval, in seconds, between health checks of an individual instance. Defaults to 10, must be between 5 and 300

      # "service.beta.kubernetes.io/aws-load-balancer-healthcheck-timeout" = "30"
      # # The amount of time, in seconds, during which no response means a failed health check. This value must be less than the service.beta.kubernetes.io/aws-load-balancer-healthcheck-interval value. Defaults to 5, must be between 2 and 60

      # "service.beta.kubernetes.io/aws-load-balancer-healthcheck-protocol" = "TCP"
      # "service.beta.kubernetes.io/aws-load-balancer-healthcheck-port"     = "traffic-port"
      # # can be integer or traffic-port

      # "service.beta.kubernetes.io/aws-load-balancer-healthcheck-path" = "/"
      # # health check path for HTTP(S) protocols
    }
  }
  spec {
    selector = {
      app = var.app_name
    }

    type = "LoadBalancer"
    # type = "NodePort"

    port {
      port        = var.port_dev
      target_port = var.port_dev
      # node_port   = 30000
      protocol = "TCP"
    }
  }
  depends_on = [var.helm_release]

}

# Create a local variable for the load balancer name.
locals {
  lb_name = split("-", split(".", kubernetes_service.api_service_lb.status.0.load_balancer.0.ingress.0.hostname).0).0
}

output "load_balancer_name" {
  value = local.lb_name
}

output "load_balancer_hostname" {
  value = kubernetes_service.api_service_lb.status.0.load_balancer.0.ingress.0.hostname
}
