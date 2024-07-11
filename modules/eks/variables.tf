variable "cluster_name" {
  description = "cluster_name"
  type        = string
}
variable "region" {
  description = "region"
  type        = string
}
variable "vpc_cidr" {
  description = "cidr block for vpc (if created)"
  type        = string
}
variable "vpc_id" {
  description = "vpc id"
  type        = string
}
variable "public_subnets" {
  description = "subnets used in eks cluster"
  type        = list(string)
}
variable "azs" {
  description = "availability zones"
  type        = list(string)
}
