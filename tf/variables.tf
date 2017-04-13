variable "ecs_cluster_name" {}
variable "ecs_container_name" {}
variable "region" {}
variable "instance_type" {}
variable "min_size" {}
variable "max_size" {}
variable "desired_capacity" {}
variable "ecs_container_port" {}

variable "availability_zones" {
  description = "The availability zones in us east"
  default = "us-east-1d,us-east-1e"
}

/* ECS optimized AMIs per region */
variable "amis" {
  default = {
    us-east-1      = "ami-275ffe31"
  }
}

variable "key_name" {
  description = "The aws ssh key name."
  default = "atb-rotation-key"
}

variable "key_file" {
  description = "The ssh public key for using with the cloud provider."
  default = ""
}

variable "ecs_ecr_loc" {
  description = "ECR location for Docker containers."
  default = "602062455022.dkr.ecr.us-east-1.amazonaws.com"
}
