resource "aws_ecs_service" "service" {

count = "${replace(replace(replace(var.create_jira,"0",var.create_confluence),"0",var.create_bamboo),"1","1")}"

  name            = "${var.ecs_container_name}-service"
  cluster         = "${var.ecs_cluster_name}"
  task_definition = "${aws_ecs_task_definition.task.arn}"
  desired_count   = "${var.desired_capacity}"
  iam_role        = "ecs_host_role"
#  iam_role        = "${aws_iam_role.ecs_host_role.name}"
#  depends_on      = ["aws_iam_role_policy.ecs_instance_role_policy"]
#  depends_on      = ["ecs_instance_role_policy"]

 placement_strategy {
        field = "attribute:ecs.availability-zone"
        type  = "spread"
    }

/* placement_strategy {
        field = "instanceId"
        type = "spread"
    }

 placement_strategy {
    type  = "binpack"
    field = "cpu"
  }
*/

  load_balancer {
    elb_name            = "${aws_elb.elb.name}"
    container_name      = "${var.ecs_container_name}"
    container_port      = "${var.ecs_container_port}"
  }
  
  lifecycle {
  create_before_destroy= true
  }
}

resource "aws_ecs_task_definition" "task" {
  family                = "${var.ecs_container_name}-task"
  #container_definitions = "${file("task_definitions/jira.json")}"
  container_definitions = <<CDEF
          [
            {
              "name": "${var.ecs_container_name}",
              "image" : "${var.ecs_ecr_loc}/${var.ecs_container_name}",
              "cpu": 512,
              "memory": 1024,
              "essential": true,
              "portMappings": [
                {
                  "containerPort": ${var.ecs_container_port},
                  "hostPort": ${var.ecs_container_port}
                }
              ]
            }
          ]
          CDEF

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

  lifecycle {
  create_before_destroy= true
  }
}
