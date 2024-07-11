output "cluster_name" {
  value = module.eks.cluster_name
}
output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}
output "aws_lb_controller_k8s_sa_name" {
  value = local.aws_lb_controller_k8s_sa_name
}
