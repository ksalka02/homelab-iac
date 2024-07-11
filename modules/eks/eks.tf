module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.1"

  cluster_name                   = var.cluster_name
  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = var.public_subnets
  control_plane_subnet_ids = var.public_subnets

  create_cluster_security_group = false
  cluster_security_group_id     = aws_security_group.eks_cluster_sg.id

  create_node_security_group = false
  # node_security_group_id     = aws_security_group.node_grp_sg.id


  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    # ami_type       = "AL2023_x86_64_STANDARD"
    ami_type = "AL2_x86_64"
    # instance_types = ["t2.medium"]
    instance_types = ["t2.small"]

    attach_cluster_primary_security_group = true
  }

  eks_managed_node_groups = {
    # # Default node group - as provided by AWS EKS
    # default_node_group = {
    #   # By default, the module creates a launch template to ensure tags are propagated to instances, etc.,
    #   # so we need to disable it to use the default template provided by the AWS EKS managed node group service
    #   use_custom_launch_template = false

    #   disk_size = 20
    # }
    # cluster_primary_security_group_id = aws_security_group.cluster_sg.id

    api-cluster-wg = {
      create_iam_role          = true
      iam_role_name            = "eks-custom-role-test"
      iam_role_use_name_prefix = false
      iam_role_description     = "EKS managed node group role test to add ssm and other policies"
      iam_role_additional_policies = {
        AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
        AmazonEBSCSIDriverPolicy           = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        AmazonEFSCSIDriverPolicy           = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        AmazonEKS_CNI_Policy               = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
        AmazonEKSWorkerNodePolicy          = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
        AmazonSSMReadOnlyAccess            = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"

      }
      min_size     = 1
      max_size     = 2
      desired_size = 1

      # instance_types = ["t2.medium"]
      instance_types = ["t2.small"]
      capacity_type  = "ON_DEMAND"

      tags = {
        ExtraTag = "helloworld"
      }
    }
  }
}
