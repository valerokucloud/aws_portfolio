# Creating a Configuration Recorder (monitors AWS resources and records their configuration):
resource "aws_config_configuration_recorder" "main" {
  name = "default"

  role_arn = aws_iam_role.config.arn

  recording_group {
    all_supported = true
  }
}

# Configuration Recorder status creation (enabled OR disabled):
resource "aws_config_configuration_recorder_status" "main" {
  name       = aws_config_configuration_recorder.main.name
  is_enabled = true

  depends_on = [aws_iam_role_policy_attachment.config,
    aws_config_delivery_channel.main,
  aws_s3_bucket_policy.config]
}