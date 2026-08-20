# S3 config rules:

# Is the bucket encrypted?
resource "aws_config_config_rule" "s3_encrypted" {
  name = "s3-bucket-server-side-encryption-enabled"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"
  }

  depends_on = [
    aws_config_configuration_recorder_status.main
  ]
}

# Prohibit public read access to buckets
resource "aws_config_config_rule" "s3_public_read_prohibited" {
  name = "s3-bucket-public-read-prohibited"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
  }

  depends_on = [
    aws_config_configuration_recorder_status.main
  ]
}

# Prohibit public write access
resource "aws_config_config_rule" "s3_public_write_prohibited" {
  name = "s3-bucket-public-write-prohibited"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
  }

  depends_on = [
    aws_config_configuration_recorder_status.main
  ]
}

# AWS Config checks that requests to S3 buckets are made over HTTPS:
resource "aws_config_config_rule" "s3_ssl_requests_only" {
  name = "s3-bucket-ssl-requests-only"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_SSL_REQUESTS_ONLY"
  }

  depends_on = [
    aws_config_configuration_recorder_status.main
  ]
}

# Is bucket versioning enabled?
resource "aws_config_config_rule" "s3_versioning_enabled" {
  name = "s3-bucket-versioning-enabled"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_VERSIONING_ENABLED"
  }

  depends_on = [
    aws_config_configuration_recorder_status.main
  ]
}

# Security Groups:

# Security Groups do not allow SSH access from the Internet
resource "aws_config_config_rule" "restricted_ssh" {
  name = "restricted-ssh"

  source {
    owner             = "AWS"
    source_identifier = "INCOMING_SSH_DISABLED"
  }

  depends_on = [
    aws_config_configuration_recorder_status.main
  ]
}

# Checks that no Security Group allows RDP (3389) access from the Internet:
resource "aws_config_config_rule" "restricted_rdp" {
  name = "restricted-rdp"

  source {
    owner             = "AWS"
    source_identifier = "RESTRICTED_INCOMING_TRAFFIC"
  }

  input_parameters = jsonencode({
    blockedPort3 = "3389"
  })

  depends_on = [
    aws_config_configuration_recorder_status.main
  ]
}

# Logs the requests received by your S3 buckets (Access logging):
resource "aws_config_config_rule" "s3_logging_enabled" {
  name = "s3-bucket-logging-enabled"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_LOGGING_ENABLED"
  }

  depends_on = [
    aws_config_configuration_recorder_status.main
  ]
}

# Lifecycle policy:
resource "aws_config_config_rule" "s3_lifecycle_policy" {
  name = "s3-lifecycle-policy-check"

  source {
    owner             = "AWS"
    source_identifier = "S3_LIFECYCLE_POLICY_CHECK"
  }

  depends_on = [
    aws_config_configuration_recorder_status.main
  ]
}



# IAM

# Checks that IAM users have MFA enabled.
# IAM is a global resource and AWS Config must evaluate it from eu-west-1.
/*
        resource "aws_config_config_rule" "iam_mfa_enabled" {
        provider = aws.ireland

        name = "iam-user-mfa-enabled"

        source {
            owner             = "AWS"
            source_identifier = "IAM_USER_MFA_ENABLED"
        }

        depends_on = [
            aws_config_configuration_recorder_status.iam_global
        ]
    }
    */

# Public / cross-account access:
resource "aws_config_config_rule" "iam_external_access_analyzer" {
  name = "iam-external-access-analyzer-enabled"

  source {
    owner             = "AWS"
    source_identifier = "IAM_EXTERNAL_ACCESS_ANALYZER_ENABLED"
  }

  depends_on = [
    aws_config_configuration_recorder_status.main
  ]
}


# EC2

# IMDSv2 (the more secure version of the Amazon EC2 Instance Metadata Service in AWS) is required:
resource "aws_config_config_rule" "ec2_imdsv2" {
  name = "ec2-imdsv2-check"

  source {
    owner             = "AWS"
    source_identifier = "EC2_IMDSV2_CHECK"
  }

  depends_on = [
    aws_config_configuration_recorder_status.main
  ]
}

# Detects EBS volumes without encryption.
resource "aws_config_config_rule" "ebs_encrypted" {
  name = "encrypted-volumes"

  source {
    owner             = "AWS"
    source_identifier = "ENCRYPTED_VOLUMES"
  }

  depends_on = [
    aws_config_configuration_recorder_status.main
  ]
}

# RDS

# RDS encryption:
resource "aws_config_config_rule" "rds_storage_encrypted" {
  name = "rds-storage-encrypted"

  source {
    owner             = "AWS"
    source_identifier = "RDS_STORAGE_ENCRYPTED"
  }

  depends_on = [
    aws_config_configuration_recorder_status.main
  ]
}

# Detects RDS instances configured for public access:
resource "aws_config_config_rule" "rds_public_access" {
  name = "rds-instance-public-access-check"

  source {
    owner             = "AWS"
    source_identifier = "RDS_INSTANCE_PUBLIC_ACCESS_CHECK"
  }

  depends_on = [
    aws_config_configuration_recorder_status.main
  ]
}

# Checks that instances have automated backups enabled:
resource "aws_config_config_rule" "rds_backup_enabled" {
  name = "rds-backup-enabled"

  source {
    owner             = "AWS"
    source_identifier = "DB_INSTANCE_BACKUP_ENABLED"
  }

  depends_on = [
    aws_config_configuration_recorder_status.main
  ]
}

# Checks that RDS logging is configured (sent to CloudWatch Logs):
resource "aws_config_config_rule" "rds_logging_enabled" {
  name = "rds-logging-enabled"

  source {
    owner             = "AWS"
    source_identifier = "RDS_LOGGING_ENABLED"
  }

  depends_on = [
    aws_config_configuration_recorder_status.main
  ]
}

# DynamoDB (DDB from now on)

# DDB encryption:
resource "aws_config_config_rule" "dynamodb_encryption_enabled" {
  name = "dynamodb-table-encryption-enabled"

  source {
    owner             = "AWS"
    source_identifier = "DYNAMODB_TABLE_ENCRYPTION_ENABLED"
  }

  depends_on = [
    aws_config_configuration_recorder_status.main
  ]
}

# DDB PITR (Point-in-Time Recovery):
resource "aws_config_config_rule" "dynamodb_pitr_enabled" {
  name = "dynamodb-pitr-enabled"

  source {
    owner             = "AWS"
    source_identifier = "DYNAMODB_PITR_ENABLED"
  }

  depends_on = [
    aws_config_configuration_recorder_status.main
  ]
}

# ECR, ECS & Containers

# ECR scanning (checks that private ECR repositories have image vulnerability scanning enabled):
resource "aws_config_config_rule" "ecr_image_scanning" {
  name = "ecr-private-image-scanning-enabled"

  source {
    owner             = "AWS"
    source_identifier = "ECR_PRIVATE_IMAGE_SCANNING_ENABLED"
  }

  depends_on = [
    aws_config_configuration_recorder_status.main
  ]
}

# ECR lifecycle. Checks that the private repository has at least one Lifecycle Policy configured:
resource "aws_config_config_rule" "ecr_lifecycle" {
  name = "ecr-private-lifecycle-policy-configured"

  source {
    owner             = "AWS"
    source_identifier = "ECR_PRIVATE_LIFECYCLE_POLICY_CONFIGURED"
  }

  depends_on = [
    aws_config_configuration_recorder_status.main
  ]
}