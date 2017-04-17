variable "ecs_cluster_name" {}
variable "min_size" {}
variable "max_size" {}
variable "desired_capacity" {}
variable "atb_jira" {}
variable "atb_confluence" {}
variable "atb_bamboo" {}
variable "instance_type" {}

variable "region" {
  description = "The AWS region to create the stack"
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "The availability zones in us east"
  default     = "us-east-1d,us-east-1e"
}

/* ECS optimized AMIs per region */
variable "amis" {
  default = {
         us-east-1 = "ami-275ffe31"
  }
}

variable "key_name" {
  description = "The aws ssh key name."
  default     = "atb-rotation-key"
}

variable "key_file" {
  description = "The ssh public key for using with the cloud provider."
  default     = ""
}

variable "ecs_ecr_loc" {
  description = "ECR location for Docker containers."
  default     = "602062455022.dkr.ecr.us-east-1.amazonaws.com"
}

variable "ecs_jira_container_name" {
  description = "The jira container name"
  default     = "atb-jira"
}
variable "ecs_jira_container_port" {
  description = "The jira container port"
  default     = 8080
}
variable "ecs_confluence_container_name" {
  description = "The confluence container name"
  default     = "atb-confluence"
}
variable "ecs_confluence_container_port" {
  description = "The confluence container port"
  default     = 8091
}
variable "ecs_bamboo_container_name" {
  description = "The atb-bamboo container name"
  default     = "atb-bamboo"
}
variable "ecs_bamboo_container_port" {
    description = "The atb-bamboo container port"
  default     = 8085

}
