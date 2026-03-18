# Obtain DB's password from AWS Secrets Manager + policy attachment:
    resource "aws_iam_policy" "secrets_manager_policy" {
        name        = "secrets-manager-access"
        description = "Allow access to Secrets Manager"

        policy = jsonencode({
            Version = "2012-10-17",
            Statement = [
            {
                Effect = "Allow",
                Action = [
                "secretsmanager:GetSecretValue",
                "secretsmanager:DescribeSecret"
                ],
                Resource = "*"
            }
            ]
        })
    }

   resource "aws_iam_role_policy_attachment" "attach_secrets_policy" {
        role       = aws_iam_role.ecs_execution_role.name
        policy_arn = aws_iam_policy.secrets_manager_policy.arn
}