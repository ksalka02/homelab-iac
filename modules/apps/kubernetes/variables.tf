variable "app_name" {
  description = "Name of application"
  type        = string
}
variable "port_dev" {
  description = "development port"
  type        = number
}
variable "port_prod" {
  description = "production port"
  type        = number
}
variable "user_data_file" {
  description = "user_data file for ec2 instance"
  type        = string
}
variable "cluster_endpoint" {
  description = "Cluster endpoint for kubernetes module file (to be referenced in k8s provider block)"
  type        = string
}
variable "cluster_certificate_authority_data" {
  description = "cluster_certificate_authority_data for kubernetes module file (to be referenced in k8s provider block)"
  type        = string
}
variable "token" {
  description = "Token for kubernetes module file (to be referenced in k8s provider block)"
  type        = string
}
variable "helm_release" {
  description = "helm_release"
  type        = any
}

# to replace "eks token" in the provider block for k8s because it gives the "ERROR: Unauthorized" after 15minutes
# variable "cluster_name" {
#   description = "eks cluster name from module outputs (github)"
#   type        = string
# }
