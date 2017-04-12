variable "availability_zones" {
  description = "The availability zones in us east"
  default = "us-east-1d,us-east-1e"
}

variable "ecs_cluster_name" {
  description = "The name of the Amazon ECS cluster."
  default = "atb-atlassian-prod"
}

variable "ecs_container_name" {
  description = "The name of the container."
  default = "atb-jira-service"
}

/* Region for ECS */
variable "region" {
  default = "us-east-1"
}

/* ECS optimized AMIs per region */
variable "amis" {
  default = {
    us-east-1      = "ami-275ffe31"
  }
}

variable "instance_type" {
  default = "m4.large"
}

variable "key_name" {
  description = "The aws ssh key name."
  default = "atb-rotation-key"
}

variable "key_file" {
  description = "The ssh public key for using with the cloud provider."
  default = ""
}

variable "min_size" {
  default = 1
}
variable "max_size" {
  default = 2
}

variable "desired_capacity" {
  default = 1
}
