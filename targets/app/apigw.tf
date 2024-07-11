module "api_gateway" {
  source        = "../../modules/apps/api-gateway"
  app_name      = "nba-player-guesser"
  port_dev      = 3000
  port_prod     = 5000
  api_json_file = "nba-player-guesser-api.json"
  lb_dns        = module.kubernetes.load_balancer_hostname
  quota_settings = {
    limit  = 20
    offset = 2
    period = "WEEK"
  }
  throttle_settings = {
    burst_limit = 1
    rate_limit  = 1
  }
}
