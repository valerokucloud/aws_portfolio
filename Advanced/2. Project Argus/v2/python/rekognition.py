import boto3
import config
from logger_config import logger

# Create the Amazon Rekognition client:
rekognition = boto3.client(
    "rekognition",
    region_name=config.AWS_REGION
)

# Returns all detected labels together with their confidence score and any detected instances.
def analyze_image(s3_key):

    try:
    
        response = rekognition.detect_labels(
            Image={
                "S3Object": {
                    "Bucket": config.BUCKET_NAME,
                    "Name": s3_key
                }
            },
            MaxLabels=20,
            MinConfidence=70    # Min 70% confidence due to balance detection accuracy
        )

    except Exception as e:
        logger.exception("❌ Error analyzing image with Rekognition.")
        return[]

    

    detections = []

    # Build a simplified list with the information required by Argus.
    for label in response["Labels"]:

        detections.append({
            "label": label["Name"],
            "confidence": label["Confidence"],
            "instances": label.get("Instances", [])
        })

    return detections