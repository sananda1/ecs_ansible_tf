resource "aws_ecs_cluster" "atb-atlassian" {
  name                 = "${var.ecs_cluster_name}"

  lifecycle {
  create_before_destroy= true
  }
}

#add modules if you need additonal containers
module "atb-jira" {
  source            = "modules/container"
  create_jira       = "${var.atb_jira}"
  create_confluence = 0
  create_bamboo     = 0

  ecs_cluster_name  = "${var.ecs_cluster_name}"
  ecs_container_name= "${var.ecs_jira_container_name}"
  ecs_container_port= "${var.ecs_jira_container_port}"
#  region            = "${var.region}"
#  instance_type     = "${var.instance_type}"
#  min_size          = "${var.min_size}"
#  max_size          = "${var.max_size}"
#  image_id          = "${lookup(var.amis, var.region)}"
#  key_name          = "${var.key_name}"
  desired_capacity  = "${var.desired_capacity}"
  ecs_ecr_loc       = "${var.ecs_ecr_loc}"
  availability_zones= "${var.availability_zones}"

}

module "atb-confluence" {
  source            = "modules/container"
  create_confluence = "${var.atb_confluence}"
  create_jira       = 0
  create_bamboo     = 0

  ecs_cluster_name  = "${var.ecs_cluster_name}"
  ecs_container_name= "${var.ecs_confluence_container_name}"
  ecs_container_port= "${var.ecs_confluence_container_port}"
#  region            = "${var.region}"
#  instance_type     = "${var.instance_type}"
#  min_size          = "${var.min_size}"
#  max_size          = "${var.max_size}"
#  image_id          = "${lookup(var.amis, var.region)}"
#  key_name          = "${var.key_name}"
  desired_capacity  = "${var.desired_capacity}"
  ecs_ecr_loc       = "${var.ecs_ecr_loc}"
  availability_zones= "${var.availability_zones}"

}

module "atb-bamboo" {
  source            = "modules/container"
  create_bamboo     = "${var.atb_bamboo}"
  create_jira       = 0
  create_confluence = 0

  ecs_cluster_name  = "${var.ecs_cluster_name}"
  ecs_container_name= "${var.ecs_bamboo_container_name}"
  ecs_container_port= "${var.ecs_bamboo_container_port}"
#  region            = "${var.region}"
#  instance_type     = "${var.instance_type}"
#  min_size          = "${var.min_size}"
#  max_size          = "${var.max_size}"
#  image_id          = "${lookup(var.amis, var.region)}"
#  key_name          = "${var.key_name}"
  desired_capacity  = "${var.desired_capacity}"
  ecs_ecr_loc       = "${var.ecs_ecr_loc}"
  availability_zones= "${var.availability_zones}"

}
