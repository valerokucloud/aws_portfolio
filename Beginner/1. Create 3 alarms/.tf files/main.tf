# MANDATORY for billing metrics:
    provider "aws" {
    region = "us-east-1"
    }

# SNS topic definition for notifications:
    resource "aws_sns_topic" "billing_alerts" {
        name = "billing-alerts-topic"
    }

# Email SNS subscription:
    resource "aws_sns_topic_subscription" "billing_email" {
        topic_arn = aws_sns_topic.billing_alerts.arn
        protocol = "email"
        endpoint = "Your_email@asdf.com"
    }

# CloudWatch alarms:
    resource "aws_cloudwatch_metric_alarm" "billing_alarm_5" {
        alarm_name = "billing-alarm-5USD"
        comparison_operator = "GreaterThanOrEqualToThreshold"
        evaluation_periods = 1
        metric_name = "EstimatedCharges5"
        namespace = "AWS/Billing"
        period = 21600  # 6h
        threshold = 5
        statistic = "Maximum"   # The statistic to apply to the alarm's associated metric
        alarm_description = "Alarm when costs exceed or are equal to 5 USD"
        actions_enabled = true
        alarm_actions = [aws_sns_topic.billing_alerts.arn]  # alarm subscription to SNS topic
    }

    resource "aws_cloudwatch_metric_alarm" "billing_alarm_25" {
        alarm_name = "billing-alarm-25USD"
        comparison_operator = "GreaterThanOrEqualToThreshold"
        evaluation_periods = 1
        metric_name = "EstimatedCharges25"
        namespace = "AWS/Billing"
        period = 21600  # 6h
        threshold = 25
        statistic = "Maximum"   # The statistic to apply to the alarm's associated metric
        alarm_description = "Alarm when costs exceed or are equal to 25 USD"
        actions_enabled = true
        alarm_actions = [aws_sns_topic.billing_alerts.arn]  # alarm subscription to SNS topic
    }

    resource "aws_cloudwatch_metric_alarm" "billing_alarm_50" {
        alarm_name = "billing-alarm-50USD"
        comparison_operator = "GreaterThanOrEqualToThreshold"
        evaluation_periods = 1
        metric_name = "EstimatedCharges50"
        namespace = "AWS/Billing"
        period = 21600  # 6h
        threshold = 50
        statistic = "Maximum"   # The statistic to apply to the alarm's associated metric
        alarm_description = "Alarm when costs exceed or are equal to 50 USD"
        actions_enabled = true
        alarm_actions = [aws_sns_topic.billing_alerts.arn]  # alarm subscription to SNS topic
    }