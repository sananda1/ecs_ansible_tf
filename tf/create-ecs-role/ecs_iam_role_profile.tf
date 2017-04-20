/**
 * IAM Role and Profile for ECS
 */

resource "aws_iam_role" "ecs_host_role" {
    name               = "ecs_host_role"
    assume_role_policy = "${file("policies/ecs_role.json")}"

}

resource "aws_iam_role_policy" "ecs_instance_role_policy" {
    name               = "ecs_instance_role_policy"
    policy             = "${file("policies/ecs_instance_role_policy.json")}"
    role               = "${aws_iam_role.ecs_host_role.id}"
}

resource "aws_iam_instance_profile" "ecs_profile" {
    name               = "ecs_instance_profile"
    path               = "/"
    role              = "${aws_iam_role.ecs_host_role.id}"
#    roles              = ["ecs_host_role"]
}
