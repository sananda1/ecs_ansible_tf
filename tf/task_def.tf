resource "aws_ecs_task_definition" "service" {
  family                = "run-jira-service"
  container_definitions = "${file("task_definitions/jira.json")}"

/*
volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

 placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-east-1d, us-east-1e]"
  }
  */
}

resource "aws_ecs_service" "service" {
  name            = "run-jira-service"
  cluster         = "${aws_ecs_cluster.atb-atlassian.name}"
  task_definition = "${aws_ecs_task_definition.service.arn}"
  desired_count   = 1
  iam_role        = "${aws_iam_role.ecs_host_role.name}"
  depends_on      = ["aws_iam_role_policy.ecs_instance_role_policy"]

 placement_strategy {
        field = "attribute:ecs.availability-zone"
        type  = "spread"
    }

/* placement_strategy {
        field = "instanceId"
        type = "spread"
    }
]
 placement_strategy {
    type  = "binpack"
    field = "cpu"
  }
*/

  load_balancer {
    elb_name            = "${aws_elb.atlassian-jira-elb.name}"
    container_name      = "${var.ecs_container_name}"
    container_port      = 8080
  }

}