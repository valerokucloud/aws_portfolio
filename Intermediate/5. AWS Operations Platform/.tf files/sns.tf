# SNS topic creation for CW alarms:
    resource "aws_sns_topic" "operations_alerts" {
    name = "${var.project_name}-alerts"

    tags = {
        Name = "${var.project_name}-alerts"
    }
}

# SNS subscription:
    resource "aws_sns_topic_subscription" "operations_email" {
    topic_arn = aws_sns_topic.operations_alerts.arn
    protocol  = "email"
    endpoint  = var.alert_email
}