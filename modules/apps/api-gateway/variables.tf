variable "app_name" {
  description = "value"
  type        = string
}
variable "api_json_file" {
  description = "value"
  type        = string
}
variable "port_dev" {
  description = "value"
  type        = number
}
variable "port_prod" {
  description = "value"
  type        = number
}
variable "lb_dns" {
  description = "value"
  type        = string
}
variable "quota_settings" {
  description = "quota settings for api gateway usage plan"
  type = object({
    limit  = number
    offset = number
    period = string
  })
}
variable "throttle_settings" {
  description = "throttle settings for api gateway usage plan"
  type = object({
    burst_limit = number
    rate_limit  = number
  })
}
