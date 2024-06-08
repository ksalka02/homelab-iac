variable "app_name" {
  description = "Name of application"
  type        = string
}

variable "private_subnets" {
  description = "A list of private subnets"
  type        = list(string)
}

variable "port_dev" {
  description = "development port"
  type        = number
}

variable "port_prod" {
  description = "production port"
  type        = number
}

variable "vpc" {
  description = "vpc_id"
  type        = string
}

variable "instance_type" {

  description = "type of instance"
  type        = string
}

variable "image_id" {
  description = "imgae id to be used for instance"
  type        = string
}

variable "key_name" {
  description = "key name for templates"
  type        = string
}

variable "min_size" {
  description = "minimum autoscale size"
  type        = number

}

variable "max_size" {
  description = "maximum autoscale size"
  type        = number

}

variable "desired_capacity" {
  description = "desired capacity for autoscale"
  type        = number
}

variable "availability_zones" {
  description = "AZ for autoscale"
  type        = list(string)

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

variable "user_data_file" {
  description = "user_data file for ec2 instance"
  type        = string
}

variable "api_json_file" {
  description = "json file for apigateway rest api"
  type        = string
}

