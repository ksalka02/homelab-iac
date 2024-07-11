locals {
  cluster_name                       = data.terraform_remote_state.eks.outputs.cluster_name
  cluster_endpoint                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
  cluster_certificate_authority_data = data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data
  aws_lb_controller_k8s_sa_name      = data.terraform_remote_state.eks.outputs.aws_lb_controller_k8s_sa_name
}
