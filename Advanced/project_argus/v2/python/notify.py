import config
import boto3
from logger_config import logger


class NotificationService:
    """
    Service responsible for sending notifications through Amazon SNS.

    This class initializes an SNS client using the default AWS
    credential provider chain and publishes notification messages
    to a configured SNS topic.
    """

# Init Notification service
    def __init__(self):

        # Loading SNS ARN topic from env variable
        self.topic_arn = config.SNS_TOPIC_ARN
        self.sns = boto3.client(
            "sns",
            region_name=config.AWS_REGION
)

    # Send notification variable:
    def send_notification(
        self,
        detections: list,
        s3_key: str

    # Returning bool (true/false)
    ) -> bool:

        subject = "🚨 Argus Alert"

        # Group by all the objects in only SNS message:
        objects = "\n".join(
            f"• {detection['label']} ({detection['confidence']:.2f}%)"
            for detection in detections
        )

        # Message definition:
        message = (
            "Argus has detected one or more interesting objects.\n\n"
            "Detected Objects:\n"
            f"{objects}\n\n"
            "S3 Object:\n"
            f"{s3_key}"
        )

        try:

            # Publishing through SNS:
            response = self.sns.publish(
                TopicArn=self.topic_arn,
                Subject=subject,
                Message=message
            )

            # Message to User:
            logger.info(
                f"📨 SNS notification sent | "
                f"message_id={response['MessageId']}"
            )
            logger.info("────────────────────────────────")

            return True

        # Exception part:
        except Exception as error:

            logger.exception(
                f"Unable to send SNS notification: {error}"
            )

            return False