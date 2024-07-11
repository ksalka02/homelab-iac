module "helm" {
  source = "../../modules/apps/helm"

  cluster_name                       = local.cluster_name
  cluster_endpoint                   = local.cluster_endpoint
  cluster_certificate_authority_data = local.cluster_certificate_authority_data
  aws_lb_controller_k8s_sa_name      = local.aws_lb_controller_k8s_sa_name
  token                              = data.aws_eks_cluster_auth.cluster.token
}
