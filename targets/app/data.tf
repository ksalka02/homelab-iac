data "aws_eks_cluster_auth" "cluster" {
  name = local.cluster_name
}
