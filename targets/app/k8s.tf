module "kubernetes" {
  source                             = "../../modules/apps/kubernetes"
  app_name                           = "nba-player-guesser"
  port_dev                           = 3000
  port_prod                          = 5000
  user_data_file                     = "nba-player-guesser-userdata.sh"
  cluster_endpoint                   = local.cluster_endpoint
  cluster_certificate_authority_data = local.cluster_certificate_authority_data
  token                              = data.aws_eks_cluster_auth.cluster.token
  helm_release                       = module.helm.helm_release
}
