resource "kubernetes_config_map" "api_configmap" {
  metadata {
    name = "api-configmap"
  }

  data = {
    PORT = var.port_dev
  }
}
