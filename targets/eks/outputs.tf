output "cluster_name" {
  value = module.eks_cluster.cluster_name
}
output "cluster_endpoint" {
  value = module.eks_cluster.cluster_endpoint
}
output "cluster_certificate_authority_data" {
  value     = module.eks_cluster.cluster_certificate_authority_data
  sensitive = true
}
output "aws_lb_controller_k8s_sa_name" {
  value = module.eks_cluster.aws_lb_controller_k8s_sa_name
}
