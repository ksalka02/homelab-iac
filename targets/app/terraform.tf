terraform {
  required_version = ">= 1.0"

  backend "s3" {
    bucket  = "terraform-tc-state-ks"
    key     = "api001/app/terraform.tfstate"
    region  = "us-east-1"
    profile = "iamadmin"
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 0" # "hashicorp/aws" (latest)
    }
  }
}

data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket  = "terraform-tc-state-ks"
    key     = "api001/eks/terraform.tfstate"
    region  = "us-east-1"
    profile = "iamadmin"
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "iamadmin"
}

# provider "kubernetes" {
#   host                   = module.eks_shared_infra.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks_shared_infra.cluster_certificate_authority_data)
#   token                  = data.aws_eks_cluster_auth.cluster.token
# }
