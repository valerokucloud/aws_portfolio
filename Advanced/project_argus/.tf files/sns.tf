# Topic creation:
    resource "aws_sns_topic" "argus_alerts" {
    name = "argus_alerts"
}

# Topic subscription creation:
    resource "aws_sns_topic_subscription" "email" {
      topic_arn = aws_sns_topic.argus_alerts.arn
      protocol = "email"
      endpoint = var.alert_email
    }