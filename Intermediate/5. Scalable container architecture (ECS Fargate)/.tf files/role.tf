# ECS task execution role + policy attachment_
    resource "aws_iam_role" "ecs_execution_role" {
        name = "ecsTaskExecutionRole"
        assume_role_policy = jsonencode({
            Version = "2012-10-17"
            Statement = [
            {
                Effect = "Allow"
                Principal = {
                Service = "ecs-tasks.amazonaws.com"
                }
                Action = "sts:AssumeRole"
            }
            ]
        })
    }

    resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
        role = aws_iam_role.ecs_execution_role.id
        policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ECS Task role (app permission):
    resource "aws_iam_role" "ecs_task_role" {
        name = "ecsTaskRole"
        assume_role_policy = jsonencode({
            Version = "2012-10-17"
            Statement = [
            {
                Effect ="Allow"
                Principal = {
                    Service = "ecs-tasks.amazonaws.com"
                }
                Action = "sts:AssumeRole"
            }
            ]
        })
}

