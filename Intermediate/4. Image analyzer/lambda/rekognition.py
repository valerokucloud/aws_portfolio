import json
from os import environ
import logging
import boto3
from botocore.exceptions import ClientError

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

rekognition = boto3.client('rekognition')


def lambda_handler(event, context):

    try:
        # Parsing the received body
        body = json.loads(event["body"])

        # Input validation
        if "fileKey" not in body:
            raise ValueError("fileKey missing in request body")

        key = body["fileKey"]
        bucket = environ["BUCKET"]

        # S3 image
        image = {
            "S3Object": {
                "Bucket": bucket,
                "Name": key
            }
        }

        # Rekognition's face
        response = rekognition.detect_faces(
            Image=image,
            Attributes=['ALL']
        )

        faces = response["FaceDetails"]

        # If no faces:
        if len(faces) == 0:
            raise ValueError("No faces detected")

        results = []

        # Processing every detected face
        for index, face in enumerate(faces):

            emotions = face["Emotions"]

            # Emotions formatting:
            emotion_list = [
                {
                    "emotion": e["Type"],
                    "confidence": round(e["Confidence"], 2)
                }
                for e in emotions
            ]

            # Bounding box for knowing every face position:
            box = face["BoundingBox"]

            results.append({
                "faceNumber": index + 1,
                "position": box,
                "emotions": emotion_list
            })

        logger.info(f"{len(faces)} faces detected in {key}")

        # Final response:
        return {
            "statusCode": 200,
            "body": json.dumps({
                "facesDetected": len(faces),
                "faces": results
            })
        }

    except ClientError as err:

        message = err.response["Error"]["Message"]
        logger.error(message)

        return {
            "statusCode": 400,
            "body": json.dumps({
                "error": "AWS Error",
                "message": message
            })
        }

    except ValueError as err:

        logger.warning(str(err))

        return {
            "statusCode": 400,
            "body": json.dumps({
                "error": "InvalidImage",
                "message": str(err)
            })
        }