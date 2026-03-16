# 5. Scalable container architecture (ECS Fargate)
 
## Difficulty: Intermediate

## Project’s Author 
* [Antonio Valero](https://www.linkedin.com/in/avalero89/) 
<br>

## Project overview: showcase of your skills, experience and accomplishments to potential employers or clients. 

 This project provisions a simple Flask-based REST API that stores and retrieves messages from a PostgreSQL DB (RDS), running in a Docker container on ECS Fargate behind an Application Load Balancer.
<br>
## Architecture:
![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/4.%20Image%20analyzer/Architecture/principal_arch.png)
<br>

## Best practices
* Infrastructure as Code using Terraform for reproducible deployments.
* Containerized application deployment with Docker on ECS Fargate.
* Secure credential management using AWS Secrets Manager.
* Network isolation with RDS deployed in private subnets inside a VPC.
* Least-privilege access control using IAM roles and Security Groups.
* Centralized logging and monitoring with Amazon CloudWatch.
<br>


### Deployment: 
<br>

**1.Network infrastructure**
* VPC creation.
* Public subnets: used by the Application Load Balancer (ALB).
* Private subnets: used by ECS Fargate tasks and RDS PostgreSQL DB (not accessible from the Internet).
* Internet Gateway: allows resources in public subnets to communicate with the Internet.
* NAT Gateway: allow resources in private subnets to access for outbound traffic.
<br>

**2.Security**
* Load Balacer Security Group: allow HTTP traffic (port 80) from the Internet.
* ECS Security Group: allows traffic only from the ALB. This prevent direct internet access to the containers.
* RDS Security Group: allow DB connections (port 5432) only from ECS. This protect the DB from external access.
<br>

**3.Database (RDS PostgreSQL)**
* RDS PostgreSQL instance deployed in private subnets (2, in different AZs for High Availability).
<br>

**4.Application Load Balancer**
* Main responsibilities: receive HTTP traffic --> forward requests to ECS asks + perform health checks.
<br>

**5. IAM roles**
* ECS Execution role: allows ECS to pull container images & sending logs to CloudWatch.
* ECS Task role: allows the running application to access Secrets Manager & retrieving DB credentials.
<br>

**6. ECS Fargate**
* ECS Cluster: logical grouping of container services
* Task definition: defines how the container runs (Docker image, CPU and memory, exposed ports, env. variables, logging config).
* ECS Serice: ensures the container is continously running.
<br>

**7. Flask application (file app.py)**
* The application provides a simple API to interact with PostgreSQL. Available endpoints:
  * GET / (Health check).
  * GET /messages (returns all stored messages).
  * POST /messages (inserts a new message into PostgreSQL).
* DB initialization: when the app starts, it ensures the required table exists
<br>

**8. Building the Docker Image**
* The application runs inside a Docker container built from:
  * Dockerfile
  * App.py
  * Requirements.txt 
* Build the image from the application directory '(TF directory/app)'. This command creates a Docker image containing the Flask application and its dependencies.
  docker build -t <dockerhub_user>/ecs-flask-api:latest .
<br>

**9. Push the image to Docker Hub**
* Login to Docker Hub:
  docker login
* Push the image:
  docker push <dockerhub_user>/ecs-flask-api:latest
  Once uploaded, ECS can download the image directly from Docker Hub
<br>

**10. Deploying the infrastructure**


## Project results
* Private cloud networking using VPC + public/private subnets.
* Containerized Flask REST API deployed on ECS Fargate.
* HTTP access through an Application Load Balancer.
* PostgreSQL DB hosted on RDS for data persistence.
* Secure DB credentials managed with Secrets Manager.
* Private cloud networking using VPC + public/private subnets.
* Container logs collected and monitored with CloudWatch.
* Infrastructure fully reproducible using Terraform.
<br>



## References
- [Using Amazon VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)<br>
- [Using AWS Identity and Access Management (IAM)](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)<br>
- [Using Amazon ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html)<br>
- [Using AWS Fargate](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html)<br>
- [Using Application Load Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)<br>
- [Using Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html)<br>
- [Using AWS Secrets Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html)<br>
- [Using Amazon CloudWatch](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/WhatIsCloudWatch.html)<br>

 

