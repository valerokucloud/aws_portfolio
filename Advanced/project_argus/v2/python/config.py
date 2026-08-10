"""
Centralized application configuration.

Configuration values are read from environment variables when available.
If an environment variable is not defined, a default value is used.

This approach allows the same application code to run in local
development, Docker containers, and future cloud environments
without requiring code changes.
"""

import os

# --------------------------------------------------
# AWS Configuration
# --------------------------------------------------

AWS_REGION = os.getenv("AWS_REGION")
BUCKET_NAME = os.getenv("BUCKET_NAME")
SNS_TOPIC_ARN = os.getenv("SNS_TOPIC_ARN")


# --------------------------------------------------
# Camera Configuration
# --------------------------------------------------
CAMERA_USERNAME = os.getenv("CAMERA_USERNAME")
CAMERA_PASSWORD = os.getenv("CAMERA_PASSWORD")
CAMERA_HOST = os.getenv("CAMERA_HOST")
CAMERA_PORT = os.getenv("CAMERA_PORT", "554")
CAMERA_STREAM = os.getenv("CAMERA_STREAM", "stream1")

CAMERA_RTSP = (
    f"rtsp://{CAMERA_USERNAME}:{CAMERA_PASSWORD}"
    f"@{CAMERA_HOST}:{CAMERA_PORT}/{CAMERA_STREAM}"
)
