resource "aws_ecs_cluster" "atb-atlassian" {
  name                 = "${var.ecs_cluster_name}"
}

