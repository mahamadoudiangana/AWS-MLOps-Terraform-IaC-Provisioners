# _`AWS MLOps Infrastructure with Terraform Provisioners`_ <br>

_`This project showcases an AWS MLOps infrastructure setup using Terraform Infrastructure as Code (IaC). It demonstrates the use of file provisioners, local-exec provisioners, and remote-exec provisioners to automate the deployment and configuration of cloud resources for a scalable machine learning environment.`_

## _`Key Infrastructure Components:`_ <br>

***Networking:*** Deployed VPCs, subnets, route tables, and associations to structure network access and routing.
***Security:*** Configured security groups to allow SSH (port 22), ICMP (ping), and HTTP (port 80) access exclusively from the home network IP address, with corresponding egress rules.
***Compute:*** Provisioned EC2 instances for workload deployment and machine learning operations. <br>

_`By leveraging Terraform's provisioners, this project highlights automated file transfers, custom local command executions, and remote command executions to simplify and enhance the deployment workflow in a reproducible and efficient manner. This infrastructure setup uses the AWS provider to ensure compatibility and reliability within the AWS ecosystem.`_






