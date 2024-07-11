########################
# nba-player-guesser-eks
########################

module "eks_cluster" {
  source         = "../../modules/eks"
  cluster_name   = "nba-player-guesser-1"
  region         = "us-east-1"
  azs            = ["us-east-1a", "us-east-1b", "us-east-1c"]
  vpc_cidr       = "192.168.0.0/16"
  vpc_id         = "vpc-0d6efc895372d401e"
  public_subnets = ["subnet-0f83c4d4c6e72d6da", "subnet-01812b90cacb6f709", "subnet-0099a4eda4876b366"]
}
