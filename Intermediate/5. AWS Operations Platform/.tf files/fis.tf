# FIS (Fault Injection Simulator) template definition:
  data "aws_region" "current" {}

  resource "aws_fis_experiment_template" "cpu_stress" {
    description = "CPU stress test for AWS Operations Platform"

    role_arn = aws_iam_role.fis.arn

    stop_condition {
      source = "none"
    }

    action {
      name      = "cpu-stress"
      action_id = "aws:ssm:send-command"

      parameter {
        key   = "documentArn"
        value = "arn:aws:ssm:${data.aws_region.current.name}::document/AWSFIS-Run-CPU-Stress"
      }

      parameter {
        key = "documentParameters"
        value = jsonencode({
          DurationSeconds     = "300" # Doc. duration = 5 min
          InstallDependencies = "True"
          CPU                 = "100" # Stress level
        })
      }

      parameter {
        key   = "duration"
        value = "PT2M"        # Command duration = 2 min
      }

      target {
        key   = "Instances"
        value = "ec2_target"
      }
    }

    target {
      name           = "ec2_target"
      resource_type  = "aws:ec2:instance"
      selection_mode = "COUNT(1)"

      resource_tag {
        key   = "Name"
        value = "${var.project_name}-ec2-1"
      }
    }

    tags = {
      Name = "${var.project_name}-fis-cpu-stress"
    }
}


# FIS memory use template.
# FIS memory stress targets allocation, not an exact CloudWatch 100% usage.
    resource "aws_fis_experiment_template" "memory_stress" {
    description = "Memory stress test for AWS Operations Platform"

    role_arn = aws_iam_role.fis.arn

    stop_condition {
        source = "none"
    }

    action {
        name      = "memory-stress"
        action_id = "aws:ssm:send-command"

        parameter {
        key   = "documentArn"
        value = "arn:aws:ssm:${data.aws_region.current.name}::document/AWSFIS-Run-Memory-Stress"
        }

        parameter {
        key   = "documentParameters"
        value = jsonencode({
            DurationSeconds     = "300"
            InstallDependencies = "True"
            Percent              = "100"
            Workers              = "1"
        })
        }

        parameter {
        key   = "duration"
        value = "PT5M"
        }

        target {
        key   = "Instances"
        value = "ec2_target"
        }
    }

    target {
        name           = "ec2_target"
        resource_type  = "aws:ec2:instance"
        selection_mode = "COUNT(1)"

        resource_tag {
        key   = "Name"
        value = "${var.project_name}-ec2-1"
        }
    }

    tags = {
        Name = "${var.project_name}-fis-memory-stress"
    }
}