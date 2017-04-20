/*
 * All cloudwatch settings and event rules can be configured here
 */
resource "aws_cloudwatch_log_group" "log_group" {
  name 				= "${var.ecs_cluster_name}"
  retention_in_days = 5

  tags {
    ECS-CLUSTER = "${var.ecs_cluster_name}"
  }
}