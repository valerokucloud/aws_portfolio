
# Alarm - BytesDownloaded
resource "aws_cloudwatch_metric_alarm" "bytes_downloaded" {
  alarm_name          = "cloudfront-bytes-downloaded"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "BytesDownloaded"   # Key value
  namespace           = "AWS/CloudFront"
  period              = 300
  statistic           = "Sum"
  threshold           = 100000000 # 100 MB in 5 min

  dimensions = {
    DistributionId = aws_cloudfront_distribution.s3_distribution.id
    Region         = "Global"
  }

  alarm_description = "Alert when more than 100MB are downloaded in 5 min"
  treat_missing_data = "notBreaching"
}

# Alarm - Requests
resource "aws_cloudwatch_metric_alarm" "requests" {
  alarm_name          = "cloudfront-requests"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Requests"  # Key value
  namespace           = "AWS/CloudFront"
  period              = 300
  statistic           = "Sum"
  threshold           = 10000 # More than 10,000 requests in 5 min

  dimensions = {
    DistributionId = aws_cloudfront_distribution.s3_distribution.id
    Region         = "Global"
  }

  alarm_description = "Alert when there are more than 10k requests in 5 min"
  treat_missing_data = "notBreaching"
}

# Alarm - 5xxErrorRate
resource "aws_cloudwatch_metric_alarm" "error_5xx" {
  alarm_name          = "cloudfront-5xx-error-rate"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "5xxErrorRate"  # Key value
  namespace           = "AWS/CloudFront"
  period              = 300
  statistic           = "Average"
  threshold           = 1 # >1% of errors 5xx

  dimensions = {
    DistributionId = aws_cloudfront_distribution.s3_distribution.id
    Region         = "Global"
  }

  alarm_description = "Alert when the percentage of 5xx errors exceeds 1%"
  treat_missing_data = "notBreaching"
}

# Alarm - 4xxErrorRate
resource "aws_cloudwatch_metric_alarm" "error_4xx" {
  alarm_name          = "cloudfront-4xx-error-rate"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "4xxErrorRate"  # Key value
  namespace           = "AWS/CloudFront"
  period              = 300
  statistic           = "Average"
  threshold           = 5 # >5% of errors 4xx

  dimensions = {
    DistributionId = aws_cloudfront_distribution.s3_distribution.id
    Region         = "Global"
  }

  alarm_description = "Alert when the percentage of 4xx exceeds 5%"
  treat_missing_data = "notBreaching"
}
