# CW log group definition
# CW Agent EC2 install + config
  resource "aws_cloudwatch_log_group" "operations" {
    name              = "/aws/operations/${var.project_name}"
    retention_in_days = 7

    tags = {
      Name = "${var.project_name}-logs"
    }
  }

  resource "aws_ssm_association" "cloudwatch_agent" {
    name = "AWS-ConfigureAWSPackage"

    association_name = "${var.project_name}-cloudwatch-agent"

    targets {
      key    = "InstanceIds"
      values = aws_instance.operations[*].id
    }

    parameters = {
      action  = "Install"
      name    = "AmazonCloudWatchAgent"
      version = "latest"
    }

    wait_for_success_timeout_seconds = 300
  }

  resource "aws_ssm_parameter" "cloudwatch_agent_config" {
    name = "/operations/cloudwatch-agent-config"
    type = "String"

      # CW Agent (memory metrics):
        value = jsonencode({
          metrics = {
            namespace = "CWAgent"

            metrics_collected = {
              mem = {
                measurement = [
                  "mem_used_percent"
                ]
                metrics_collection_interval = 60
              }
            }
          }

      logs = {
        logs_collected = {
          files = {
            collect_list = [
              {
                file_path        = "/var/log/operations.log"
                log_group_name   = aws_cloudwatch_log_group.operations.name
                log_stream_name  = "{instance_id}/operations"
              }
            ]
          }
        }
      }
    })

    tags = {
      Name = "${var.project_name}-cloudwatch-agent-config"
    }
  }

  resource "aws_ssm_association" "cloudwatch_agent_config" {
    name = "AmazonCloudWatch-ManageAgent"

    depends_on = [
      aws_ssm_association.cloudwatch_agent
    ]

    targets {
      key    = "InstanceIds"
      values = aws_instance.operations[*].id
    }

    parameters = {
      action                        = "configure"
      mode                          = "ec2"
      optionalConfigurationSource   = "ssm"
      optionalConfigurationLocation = aws_ssm_parameter.cloudwatch_agent_config.name
      optionalRestart               = "yes"
    }
}

# CW metric filter:
  resource "aws_cloudwatch_log_metric_filter" "operations_errors" {
    name           = "${var.project_name}-errors"
    log_group_name = aws_cloudwatch_log_group.operations.name
    pattern        = "ERROR"

    metric_transformation {
      name      = "ErrorCount"
      namespace = "AWSOperations"
      value     = "1"
    }
}

# CW Alarm (alarm when an ERROR is detected in operations logs):
  resource "aws_cloudwatch_metric_alarm" "operations_errors" {
    alarm_name          = "${var.project_name}-errors"
    alarm_description   = "Alarm when an ERROR is detected in operations logs"

    namespace           = "AWSOperations"
    metric_name         = "ErrorCount"
    statistic           = "Sum"

    period              = 60
    evaluation_periods  = 1
    threshold           = 1
    comparison_operator = "GreaterThanOrEqualToThreshold"

    treat_missing_data = "notBreaching"

    alarm_actions = [
      aws_sns_topic.operations_alerts.arn
    ]

    tags = {
      Name = "${var.project_name}-errors-alarm"
    }
}

# CW event rule (EventBridge)
# If the EC2 instance stops or is deleted, EventBridge detects the event --> we will send a message to SNS + permissions for EventBridge to publish to SNS:
  resource "aws_cloudwatch_event_rule" "ec2_state_change" {
    name        = "${var.project_name}-ec2-state-change"
    description = "Detect EC2 instance state changes"

    event_pattern = jsonencode({
      source = [
        "aws.ec2"
      ]

      detail-type = [
        "EC2 Instance State-change Notification"
      ]

      detail = {
        state = [
          "stopped",
          "terminated"
        ]
      }
    })

    tags = {
      Name = "${var.project_name}-ec2-state-change"
    }
  }

  resource "aws_cloudwatch_event_target" "ec2_state_change_sns" {
    rule      = aws_cloudwatch_event_rule.ec2_state_change.name
    target_id = "SendToSNS"
    arn       = aws_sns_topic.operations_alerts.arn
  }

  data "aws_iam_policy_document" "eventbridge_sns" {
    statement {
      effect = "Allow"

      actions = [
        "SNS:Publish"
      ]

      principals {
        type        = "Service"
        identifiers = ["events.amazonaws.com"]
      }

      resources = [
        aws_sns_topic.operations_alerts.arn
      ]
    }
  }

  resource "aws_sns_topic_policy" "eventbridge_sns" {
    arn    = aws_sns_topic.operations_alerts.arn
    policy = data.aws_iam_policy_document.eventbridge_sns.json
}


# If SSM sends commands to the EC2 instances and the operation fails, times out, or is canceled, an event is created.
# We connect to the existing SNS
# We grant EventBridge permission for SMS to publish
# We attach the policy

  resource "aws_cloudwatch_event_rule" "ssm_command_failed" {
    name        = "${var.project_name}-ssm-command-failed"
    description = "Detect failed Systems Manager Run Command executions"

    event_pattern = jsonencode({
      source = [
        "aws.ssm"
      ]

      detail-type = [
        "EC2 Command Status-change Notification"
      ]

      detail = {
        status = [
          "Failed",
          "TimedOut",
          "Canceled"
        ]
      }
    })

    tags = {
      Name = "${var.project_name}-ssm-command-failed"
    }
  }

  resource "aws_cloudwatch_event_target" "ssm_command_failed_sns" {
    rule      = aws_cloudwatch_event_rule.ssm_command_failed.name
    target_id = "SendToSNS"
    arn       = aws_sns_topic.operations_alerts.arn
  }

  data "aws_iam_policy_document" "eventbridge_ssm_sns" {
    statement {
      effect = "Allow"

      actions = [
        "SNS:Publish"
      ]

      principals {
        type        = "Service"
        identifiers = ["events.amazonaws.com"]
      }

      resources = [
        aws_sns_topic.operations_alerts.arn
      ]
    }
}
