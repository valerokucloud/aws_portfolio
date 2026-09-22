# 'Hostname' command execution via SSM (2 instances)
  resource "aws_ssm_association" "hostname" {
    name = "AWS-RunShellScript"

    targets {
      key    = "InstanceIds"
      values = aws_instance.operations[*].id
    }

    parameters = {
      commands = "hostname"
    }
}

# Patch Manager baseline for Amazon Linux + association:
  resource "aws_ssm_patch_baseline" "amazon_linux" {
    name             = "operations-patch-baseline"
    operating_system = "AMAZON_LINUX_2023"

    approval_rule {
      approve_after_days = 7
      compliance_level   = "CRITICAL"

      patch_filter {
        key    = "CLASSIFICATION"
        values = ["Security"]
      }
    }

    description = "Security patch baseline for Amazon Linux 2023"
  }

  resource "aws_ssm_association" "patching" {
    name             = "AWS-RunPatchBaseline"
    association_name = "${var.project_name}-patching"

    targets {
      key    = "InstanceIds"
      values = aws_instance.operations[*].id
    }

    parameters = {
      Operation = "Scan"
    }

    schedule_expression = "cron(0 3 ? * SUN *)"
}
