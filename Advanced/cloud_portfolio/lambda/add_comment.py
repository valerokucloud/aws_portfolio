import json
import boto3
import os
from datetime import datetime, timezone

# Creating DDB resource
dynamodb = boto3.resource("dynamodb")

# Get the DDB table name from env variables
table = dynamodb.Table(
    os.environ["TABLE_NAME"]
)

def handler(event, context):
    # Extract the JSON payload received from API Gateway.
    # It contains the information required to create a new comment.
    body = json.loads(event["body"])

    # Store the new comment in the DB
    table.put_item(
    Item={
        "project_slug": body["project_slug"],
        "created_at": datetime.now(timezone.utc).isoformat(),
        "user": body["user"],
        "comment": body["comment"],
        "type": "comment"
    }
)
    # Return a success response
    return {
        "statusCode": 200,
        "body": json.dumps({
            "message":
                "Comment stored"
        })
    }