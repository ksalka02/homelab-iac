terraform {
  required_version = ">= 1.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 0" # "hashicorp/kubernetes" (latest)¸¸¸¸
    }
  }
}

provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)
  token                  = var.token
  # exec {
  #   api_version = "client.authentication.k8s.io/v1beta1"
  #   args        = [var.cluster_name]
  #   command     = "${path.root}/modules/shared-infra/kubernetes/get-eks-creds.sh"
  # }
}

# provider "kubernetes" {
#   host                   = module.eks_shared_infra.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks_shared_infra.cluster_certificate_authority_data)
#   token                  = data.aws_eks_cluster_auth.cluster.token
# }



