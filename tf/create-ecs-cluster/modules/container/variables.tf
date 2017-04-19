#add variables if you need additonal containers
variable "ecs_cluster_name" {}
variable "ecs_container_name" {}
variable "ecs_container_port" {}
variable "desired_capacity" {}
variable "ecs_ecr_loc" {}
variable "availability_zones" {}
variable "create_jira" {}
variable "create_confluence" {}
variable "create_bamboo" {}
variable "create_monitoring" {}
variable "elb_sg" {}

/*variable "region" {}
variable "instance_type" {}
variable "min_size" {}
variable "max_size" {}
variable "image_id" {}
variable "key_name" {}
*/
