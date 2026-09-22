# CW metric alarm (CPU >70% +2 min):
  resource "aws_cloudwatch_metric_alarm" "ec2_cpu_high" {
    alarm_name        = "${var.project_name}-ec2-cpu-high"
    alarm_description = "EC2 CPU utilization above 70%"

    namespace          = "AWS/EC2"
    metric_name        = "CPUUtilization"
    statistic          = "Average"
    period             = 120
    evaluation_periods = 1

    comparison_operator = "GreaterThanThreshold"
    threshold           = 70

    dimensions = {
      InstanceId = aws_instance.operations[0].id
    }

    treat_missing_data = "notBreaching"

    tags = {
      Name = "${var.project_name}-cpu-alarm"
    }
}
