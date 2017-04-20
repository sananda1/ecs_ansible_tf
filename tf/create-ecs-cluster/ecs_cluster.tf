terraform {
  backend "s3" {
    bucket = "atb-tf-remote-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "remote-setup" {
  backend = "s3"
  config {
    bucket = "atb-tf-remote-state"
    key    = "${var.ecs_cluster_name}/terraform.tfstate"
    region = "us-east-1"
  }
}

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
  create_monitoring = 0

  ecs_cluster_name  = "${var.ecs_cluster_name}"
  ecs_container_name= "${var.ecs_jira_container_name}"
  ecs_container_port= "${var.ecs_jira_container_port}"
  desired_capacity  = "${var.desired_capacity}"
  ecs_ecr_loc       = "${var.ecs_ecr_loc}"
  availability_zones= "${var.availability_zones}"
  elb_sg            = "${aws_security_group.load_balancers.id}"
}

module "atb-confluence" {
  source            = "modules/container"
  create_confluence = "${var.atb_confluence}"
  create_jira       = 0
  create_bamboo     = 0
  create_monitoring = 0

  ecs_cluster_name  = "${var.ecs_cluster_name}"
  ecs_container_name= "${var.ecs_confluence_container_name}"
  ecs_container_port= "${var.ecs_confluence_container_port}"
  desired_capacity  = "${var.desired_capacity}"
  ecs_ecr_loc       = "${var.ecs_ecr_loc}"
  availability_zones= "${var.availability_zones}"
  elb_sg            = "${aws_security_group.load_balancers.id}"
}

module "atb-bamboo" {
  source            = "modules/container"
  create_bamboo     = "${var.atb_bamboo}"
  create_jira       = 0
  create_confluence = 0
  create_monitoring = 0

  ecs_cluster_name  = "${var.ecs_cluster_name}"
  ecs_container_name= "${var.ecs_bamboo_container_name}"
  ecs_container_port= "${var.ecs_bamboo_container_port}"
  desired_capacity  = "${var.desired_capacity}"
  ecs_ecr_loc       = "${var.ecs_ecr_loc}"
  availability_zones= "${var.availability_zones}"
  elb_sg            = "${aws_security_group.load_balancers.id}"
}

module "atb-monitoring" {
  source            = "modules/container"
  create_monitoring = "${var.atb_monitoring}"
  create_jira       = 0
  create_confluence = 0
  create_bamboo     = 0

  ecs_cluster_name  = "${var.ecs_cluster_name}"
  ecs_container_name= "${var.ecs_monitoring_container_name}"
  ecs_container_port= "${var.ecs_monitoring_container_port}"
  desired_capacity  = "${var.desired_capacity}"
  ecs_ecr_loc       = "${var.ecs_ecr_loc}"
  availability_zones= "${var.availability_zones}"
  elb_sg            = "${aws_security_group.load_balancers.id}"
}
