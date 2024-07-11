terraform {
  required_version = ">= 1.0"

  required_providers {
    # kubernetes = {
    #   source  = "hashicorp/kubernetes"
    #   version = ">= 0" # "hashicorp/aws" (latest)¸¸¸¸
    # }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 0" # "hashicorp/aws" (latest)¸¸¸¸
    }
  }
}
