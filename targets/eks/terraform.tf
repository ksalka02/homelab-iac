terraform {
  required_version = ">= 1.0"

  backend "s3" {
    bucket  = "terraform-tc-state-ks"
    key     = "api001/eks/terraform.tfstate"
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

provider "aws" {
  region  = "us-east-1"
  profile = "iamadmin"
}
