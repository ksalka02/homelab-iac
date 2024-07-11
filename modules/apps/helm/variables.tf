variable "cluster_name" {
  description = "Cluster Name"
  type        = string
}

variable "aws_lb_controller_k8s_sa_name" {
  description = "aws_lb_controller_k8s_sa_name"
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
