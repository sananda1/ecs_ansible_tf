/**
 * Launch configuration used by autoscaling group
 */
resource "aws_launch_configuration" "ecs-atlassian-alc" {
  name                 = "${var.ecs_cluster_name}-ALC"
#  image_id             = "${var.image_id}"
  image_id             = "${lookup(var.amis, var.region)}"
  instance_type        = "${var.instance_type}"
  key_name             = "${var.key_name}" 
  security_groups      = ["${aws_security_group.ecs_instance.id}"]
  iam_instance_profile = "ecs_instance_profile"
#  iam_instance_profile = "${aws_iam_instance_profile.ecs_profile.id}"
#  iam_instance_profile = "${var.ecs_cluster_name}-instance-profile"
#  user_data            = "#!/bin/bash\necho ECS_CLUSTER=${var.ecs_cluster_name} > /etc/ecs/ecs.config"
  user_data            = "#!/bin/bash\necho ECS_CLUSTER=${var.ecs_cluster_name} > /etc/ecs/ecs.config\ndocker run -d --name dd-agent -v /var/run/docker.sock:/var/run/docker.sock:ro -v /proc/:/host/proc/:ro -v /cgroup/:/host/sys/fs/cgroup:ro -e API_KEY=2b6259409628aedb7513cce4ad63acf9 -e SD_BACKEND=docker datadog/docker-dd-agent:latest"

  lifecycle {
  create_before_destroy= true
  }
}

/**
 * Autoscaling group.
 */
resource "aws_autoscaling_group" "ecs-atlassian-asg" {
  name                 = "${var.ecs_cluster_name}-ASG"
  availability_zones   = ["${split(",", var.availability_zones)}"]
  launch_configuration = "${aws_launch_configuration.ecs-atlassian-alc.name}"
  min_size             = "${var.min_size}"
  max_size             = "${var.max_size}"
  desired_capacity     = "${var.desired_capacity}"
  
  tag {
    key                = "Name"
    value              = "${var.ecs_cluster_name}-container-instance"
    propagate_at_launch= true
  }

  lifecycle {
  create_before_destroy= true
  }
}

/**
 * Security Groups.
 */
resource "aws_security_group" "ecs_instance" {
    name               = "${var.ecs_cluster_name}-SG"
    description        = "Allows all traffic"
    #vpc_id = "${aws_vpc.main.id}"

    # TODO: remove this and replace with a bastion host for SSHing into
    # individual machines.
    ingress {
        from_port      = "${var.ecs_jira_container_port}"
        to_port        = "${var.ecs_jira_container_port}"
        protocol       = "TCP"
        cidr_blocks    = ["0.0.0.0/0"]
    }
    ingress {
        from_port      = "${var.ecs_confluence_container_port}"
        to_port        = "${var.ecs_confluence_container_port}"
        protocol       = "TCP"
        cidr_blocks    = ["0.0.0.0/0"]
    }
    ingress {
        from_port      = "${var.ecs_bamboo_container_port}"
        to_port        = "${var.ecs_bamboo_container_port}"
        protocol       = "TCP"
        cidr_blocks    = ["0.0.0.0/0"]
    }
    ingress {
        from_port      = "${var.ecs_monitoring_container_port}"
        to_port        = "${var.ecs_monitoring_container_port}"
        protocol       = "TCP"
        cidr_blocks    = ["0.0.0.0/0"]
    }
/*
    ingress {
        from_port      = "${var.ecs_container_port}"
        to_port        = "${var.ecs_container_port}"
        protocol       = "TCP"
        cidr_blocks    = ["0.0.0.0/0"]
    }

/*    ingress {
        from_port      = 0
        to_port        = 0
        protocol       = "-1"
        security_groups= ["${aws_security_group.load_balancers.id}"]
    }
*/
    egress {
        from_port      = 0
        to_port        = 0
        protocol       = "-1"
        cidr_blocks    = ["0.0.0.0/0"]
    }
  
  tags {
    Name               = "${var.ecs_cluster_name}-SG"
  }
}