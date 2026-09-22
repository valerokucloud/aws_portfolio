# Allow EC2 instances to assume this IAM role + policy/ec2 instance profile attachment:
  resource "aws_iam_role" "ec2_ssm" {
    name = "${var.project_name}-ec2-ssm-role"

    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [{
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }]
    })
  }

  resource "aws_iam_role_policy_attachment" "ssm" {
    role       = aws_iam_role.ec2_ssm.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  resource "aws_iam_instance_profile" "ec2_ssm" {
    name = "${var.project_name}-ec2-ssm-profile"
    role = aws_iam_role.ec2_ssm.name
}

# CW policy to the iam role (so that metrics and logs can be published to CW)
  resource "aws_iam_role_policy_attachment" "cw_agent" {
    role       = aws_iam_role.ec2_ssm.name
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}


# FIS role/policy creation:
  resource "aws_iam_role" "fis" {
    name = "${var.project_name}-fis-role"

    assume_role_policy = jsonencode({
      Version = "2012-10-17"

      Statement = [
        {
          Effect = "Allow"

          Principal = {
            Service = "fis.amazonaws.com"
          }

          Action = "sts:AssumeRole"
        }
      ]
    })

    tags = {
      Name = "${var.project_name}-fis-role"
    }
  }


  resource "aws_iam_role_policy" "fis" {
  name = "${var.project_name}-fis-policy"
  role = aws_iam_role.fis.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "ssm:SendCommand",
          "ssm:ListCommands",
          "ssm:ListCommandInvocations",
          "ssm:GetCommandInvocation",
          "ssm:DescribeInstanceInformation"
        ]

        Resource = "*"
      },
      {
        Effect = "Allow"

        Action = [
          "ec2:DescribeInstances"
        ]

        Resource = "*"
      }
    ]
  })
}