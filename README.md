# IaC_challenge
## Description
Cloudformation template for the IaC Challenge
## Relevant files
1. **cloudformation_template.yaml**: The template itself. it is further explained in the Design part.
2. **userdata.sh** : (For reference) The user data that the EC2 instance execute
## Design 
The design is an standard one.

For the network the template creates a VPC with private and public subnets and all the required network setup.

An AutoScaling Group (ASG) is deployed and connected to the private subnets.It has configured alarms in case It scales up or down (default parameters for the scaling are set).

Website is deployed on the EC2 of the ASG though the UserData config.The userdata setup the application user and directories, clone the git [repository given](https://github.com/dext0s/django_app) and execute the script on the root of the git repo indicated on the parameters.

To publish the Website there is a Application Load Blancer which is internet facing. This is the only way the public can reach the Website.

To access the instances by SSH a Bastion instance is created and publicly accesible by a certain Cidr range. Any network interface with the Bastion Security group can connect via SSH to the Website Servers.

The Cloudformation stack deploy or update will fail and rollback if the ELB healtcheck of the instances fail. This way a rolling update can be done without a maintanance window.
To check the healtcheck an IAM role with the proper configuration is set to the Website instances.

## Prerequisites 

There are 2 prerequisites to execute this template:

1. To have a role with enough permisions to execute the template.
2. To create a SSH key on AWS so to feed it to the template. [Check this link](https://docs.aws.amazon.com/ground-station/latest/ug/create-ec2-ssh-key-pair.html)

## Instructions 

I'm assuming you are compleatly aware on how to deploy a CloudFormation stack and I'll only provide some details about this particular template.

This are the only parameters that aren't autofilled and you have to provide an input:

1. **Name of the stack**
2. **KeyName**: The EC2 SSH key pair for the instances.
3. **OperatorEMail**: EMail which receives the alerts on scaling up or down of the ASG.

Also watch out with the VPCCidr field if you are doing the test in a non-sandbox account. As it creates a VPC it could mess with your network.

## References 

This are most of knowledge bases I've checked during the development of this challenge:

- https://aws.amazon.com/es/cloudformation/resources/templates/
- https://octopus.com/blog/ami-mappings-cloudformation
- https://www.infoq.com/articles/aws-vpc-cloudformation/
