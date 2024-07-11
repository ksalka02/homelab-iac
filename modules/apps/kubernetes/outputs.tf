output "app_name" {
  description = "app name from kubernetes deployment"
  value       = var.app_name
}
output "port_dev" {
  description = "development port"
  value       = var.port_dev
}
output "port_prod" {
  description = "production port"
  value       = var.port_prod
}
