# https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html

locals {
  aws_lb_controller_k8s_sa_name = "aws-load-balancer-controller"
}

resource "aws_iam_policy" "aws_lb_controller" {
  name = "AWSLoadBalancerControllerIAMPolicy"
  path = "/"

  # Terraform's "jsonencode" function converts a Terraform expression result to valid JSON syntax.
  policy = templatefile("${path.module}/aws_lb_controller_policy.json", {})
}


# This will create the "AmazonEKSLoadBalancerControllerRole" role and bind it to the "aws-load-balancer-controller" K8s service account
resource "null_resource" "aws_lb_controller_role_sa_binding" {

  provisioner "local-exec" {
    command = "eksctl create iamserviceaccount --cluster=${module.eks.cluster_name} --namespace=kube-system --name=${local.aws_lb_controller_k8s_sa_name} --role-name AmazonEKSLoadBalancerControllerRole --attach-policy-arn=${aws_iam_policy.aws_lb_controller.arn} --override-existing-serviceaccounts --approve --profile iamadmin"
  }

  # TODO: Update command to delete cloudformation stack
  provisioner "local-exec" {
    when    = destroy
    command = "aws cloudformation delete-stack --stack-name eksctl-nba-player-guesser-1-addon-iamserviceaccount-kube-system-aws-load-balancer-controller --profile iamadmin"
  }
  provisioner "local-exec" {
    when = destroy
    # command = "eksctl delete iamserviceaccount --name=aws-load-balancer-controller --approve --profile iamadmin"
    command = "eksctl delete iamserviceaccount --cluster=nba-player-guesser-1 --name=aws-load-balancer-controller --profile iamadmin && sleep 120"
  }
  depends_on = [module.eks]
}



