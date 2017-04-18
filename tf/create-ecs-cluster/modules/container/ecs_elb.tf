# Create a new load balancer
resource "aws_elb" "elb" {
  name              = "${var.ecs_container_name}-${var.ecs_cluster_name}"
  availability_zones= ["${split(",", var.availability_zones)}"]
  security_groups   = ["${aws_security_group.load_balancers.id}"]

/*  access_logs {
    bucket        = "foo"
    bucket_prefix = "bar"
    interval      = 60
  }
*/
  listener {
    instance_port     = "${var.ecs_container_port}"
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  /*
  listener {
    instance_port      = "${var.ecs_container_port}"
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  }
*/

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:${var.ecs_container_port}"
    interval            = 10
  }

 # instances                   = ["${aws_instance.foo.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name                = "${var.ecs_container_name}-ELB"
  }

  lifecycle {
  create_before_destroy= true
  }
}

# Create a new load balancer attachment
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = "${var.ecs_cluster_name}-ASG"
  elb                    = "${aws_elb.elb.id}"
  
#  depends_on           = ["atlassian-prod-instance-profile"]

  lifecycle {
  create_before_destroy= true
  }
}

/**
 * Security Groups.
 */
resource "aws_security_group" "load_balancers" {
    name               = "${var.ecs_container_name}-LBSG"
    description        = "Allows all traffic"
    #vpc_id = "${aws_vpc.main.id}"

    # TODO: do we need to allow ingress besides TCP 80 and 443?
    ingress {
        from_port      = 80
        to_port        = 80
        protocol       = "TCP"
        cidr_blocks    = ["0.0.0.0/0"]
    }

    # TODO: this probably only needs egress to the ECS security group.
    egress {
        from_port      = 0
        to_port        = 0
        protocol       = "-1"
        cidr_blocks    = ["0.0.0.0/0"]
    }

  tags {
    Name               ="${var.ecs_container_name}-LBSG"
  }

  lifecycle {
  create_before_destroy= true
  }
}
