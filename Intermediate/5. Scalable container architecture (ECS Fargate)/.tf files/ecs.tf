# ECS cluster creation (where tasks will be executed)
  resource "aws_ecs_cluster" "main" {
    name = "portfolio-testing"
}

# ECS task definition --> how the container is executed (resources, Docker image and port):
  resource "aws_ecs_task_definition" "app" {
    family = "portfolio-testing"
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"

    # Resources' definition:
      cpu = 256
      memory = 512

    # Container definition:
      container_definitions = jsonencode([
          {
            name = "app"
            image = "valeroku/ecs-flask-api:latest"   # Use image uploaded previously to Docker Hub
            # Everything that the container writes in stdout / stderr --> to CloudWatch Logs
            portMappings = [
                {
                    containerPort = 80
                }
            ]
            logConfiguration = {
              logDriver = "awslogs"
              options = {
                awslogs-group         = "/ecs/app"    # AWS CloudWatch Logs group name
                awslogs-region        = "eu-south-2"
                awslogs-stream-prefix = "ecs"         # "service"
              }
            }
            essential = true

              environment = [
                {
                  name  = "DB_HOST"
                  value = aws_db_instance.db.address
                },
                {
                  name  = "DB_PORT"
                  value = "5432"
                },
                {
                  name  = "DB_NAME"
                  value = "postgres"
                }
           ]
           secrets = [
            {
              name      = "DB_USER"
              valueFrom = "${aws_db_instance.db.master_user_secret[0].secret_arn}:username::"
            },
            {
              name      = "DB_PASSWORD"
              valueFrom = "${aws_db_instance.db.master_user_secret[0].secret_arn}:password::"
            }
          ]
        }
      ])
    execution_role_arn = aws_iam_role.ecs_execution_role.arn
    task_role_arn = aws_iam_role.ecs_task_role.arn
}

# ECS service:
  resource "aws_ecs_service" "app" {
    name = "ecs-app-service"
    cluster = aws_ecs_cluster.main.id
    task_definition = aws_ecs_task_definition.app.arn

    launch_type = "FARGATE"
    desired_count = 1
    force_new_deployment = true   # Allow tf destroying command

    network_configuration {
      subnets = [aws_subnet.private_a.id,
                aws_subnet.private_b.id]   # If you want HA --> declare the 2 subnets (private)
      security_groups = [aws_security_group.ecs.id]
      assign_public_ip = false
    }

    load_balancer {
      target_group_arn = aws_lb_target_group.app.arn
      container_name = "app"
      container_port = 80
    }

    # Garantiza que el listener esté listo antes de crear el servicio:
      depends_on = [ aws_lb_listener.http]
}
