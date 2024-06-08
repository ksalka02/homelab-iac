#######################
# nba-player-guesser
#######################

module "nba_player_guesser_separate_infra" {
  source             = "./modules/separate-infra"
  app_name           = "nba-player-guesser"
  vpc                = "vpc-0a6720a2dbfe01300"
  private_subnets    = ["subnet-09749969720f35b52", "subnet-0627be5b35f42fc71", "subnet-0d05fe83bb7757449"]
  instance_type      = "t2.micro"
  image_id           = "ami-03a6eaae9938c858c"
  key_name           = "api_test_key"
  availability_zones = ["us-east-1c", "us-east-1d"]
  port_dev           = 3000
  port_prod          = 5000
  min_size           = 1
  max_size           = 1
  desired_capacity   = 1
  quota_settings = {
    limit  = 20
    offset = 2
    period = "WEEK"
  }
  throttle_settings = {
    burst_limit = 1
    rate_limit  = 1
  }
  user_data_file = "nba-player-guesser-userdata.sh"
  api_json_file  = "nba-player-guesser-api.json"
}

#######################
# soccer-player-registry
#######################

module "soccer_player_registry_separate_infra" {
  source             = "./modules/separate-infra"
  app_name           = "soccer-player-registry"
  vpc                = "vpc-0a6720a2dbfe01300"
  private_subnets    = ["subnet-09749969720f35b52", "subnet-0627be5b35f42fc71", "subnet-0d05fe83bb7757449"]
  instance_type      = "t2.micro"
  image_id           = "ami-03a6eaae9938c858c"
  key_name           = "api_test_key"
  availability_zones = ["us-east-1c", "us-east-1d"]
  port_dev           = 3000
  port_prod          = 5000
  min_size           = 1
  max_size           = 1
  desired_capacity   = 1
  quota_settings = {
    limit  = 20
    offset = 2
    period = "WEEK"
  }
  throttle_settings = {
    burst_limit = 1
    rate_limit  = 1
  }
  user_data_file = "players_userdata_sql_docker.sh"
  api_json_file  = "soccer-player-registry-api.json"
}
