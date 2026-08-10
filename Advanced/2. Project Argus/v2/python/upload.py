import boto3
import config
from datetime import datetime
from logger_config import logger


# S3 client creation - Importing AK, SK, region info:
s3 = boto3.client(
    "s3",
    region_name=config.AWS_REGION
)


def upload_image(image_bytes):

    try:

         
        today = datetime.now()

        # Generate the S3 object key (year/month/day structure):
        s3_key = (
            f"events/"
            f"{today:%Y}/"
            f"{today:%m}/"
            f"{today:%d}/"
            f"{today:%Y%m%d_%H%M%S}.jpg"
        )

        # Uploading the image to S3 bucket:
        s3.put_object(
            Bucket=config.BUCKET_NAME,
            Key=s3_key,
            Body=image_bytes,
            ContentType="image/jpeg"
        )
      
        return s3_key

    except Exception:

        logger.exception("❌ Error uploading the image.")

        return None