import boto3
import json
import uuid
import os

s3 = boto3.client("s3", 
    region_name="eu-south-2",
    endpoint_url = "https://s3.eu-south-2.amazonaws.com")

BUCKET = os.environ["BUCKET"]

def lambda_handler(event, context):

    file_id = str(uuid.uuid4())
    key = f"uploads/{file_id}.jpg"

    url = s3.generate_presigned_url(
        ClientMethod="put_object",
        Params={
            "Bucket": BUCKET,
            "Key": key,
            "ContentType": "image/jpeg"
        },
        ExpiresIn=300  # 5 minutes
    )

    return {
        "statusCode": 200,
        "body": json.dumps({
            "uploadUrl": url,
            "fileKey": key
        })
    }
