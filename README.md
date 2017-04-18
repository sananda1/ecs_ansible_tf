# ecs_ansible_tf
In order to use terraform with this repo, you would need to

Create a secrets.tfvars in your local environment

    aws_access_key_id = "<aws_access_key_id>"           - access key ID from your AWS profile
    aws_secret_access_key = "<aws_secret_access_key>"   - secret access key from your AWS profile

Alternatively you can also set above to variables in your environment if you prefer. Performing step #1 or #2 will setup your environment to connect with AWS.

Secondly, you will now need to setup terraform.tfvars file with following variables

    ecs_cluster_name = "<pick a name>"  - a name that you want to see in AWS for your cluster
    instance_type = "t2.large"          - any size that is supported by AWS

    atb_jira = 1                        - this is a boolean value, if 1 it will create JIRA
    atb_confluence = 1                  - this is a boolean value, if 1 it will create Confluence
    atb_bamboo = 0                      - this is a boolean value, if 0 it will create bamboo

if you want additonal containers, say like jenkins, then you would create another value like
atb_jenkins = 1 to make this happen, ofcourse a container support will also be needed in the code for that. Look for comments in the code to find where to add the support for additonal containers.

Below variables will decide what your desired values for the container host is. With below example, if auto scaling happens, the max # of instances scaled up to would be 5, However a minimal of 2 containers will always be there to support our infrastructure needs.

    min_size = 2
    max_size = 5
    desired_capacity = 2

when doing Jenkins automation, we can create a terraform.tfvars as an output to feed into terraform automation.


Inside 
    tf/create-ecs-role - this will create necessary role and profile to ensure access for ECS and EC2 automation and runtime environment access. This needs to run once and then not needed to run again and again. Although, nothing bad will happen if you run it again. terraform will check and skip the resources
    
    tf/create-ecs-cluster - this is where the automation for cluster creation with ASG, ALC, instance and container sits. it has an implementation of terraform module that minimizes redundant code. However we may need to revisit this if we need to have different configurations for the task definitions running docker.
    
