import json
import boto3
import os

# Creating DDB resource
dynamodb = boto3.resource("dynamodb")

# Get the DDB table name from env variables
table = dynamodb.Table(
    os.environ["TABLE_NAME"]
)

def handler(event, context):
    # Read the project identifier from the API Gateway path parameters. 
    # This is used to retrieve comments for a specific portfolio project.
    project_slug = event[
        "pathParameters"
    ]["project"]

    # Query DynamoDB using the project slug as the partition key.
    response = table.query(
        KeyConditionExpression=
            boto3.dynamodb.conditions.Key(
                "project_slug"
            ).eq(project_slug)
    )

    # Filter the query results to keep only items of type "comment". 
    # This ensures that only user comments are returned, ignoring any other record types that may exist in the DynamoDB table.
    comments = [
        item
        for item in response["Items"]
        if item.get("type") == "comment"
    ]
    
    # Sort comments by creation date (newest first).
    comments.sort(
    key=lambda x:
        x["created_at"],
    reverse=True
    )

    # Return the list of comments as a JSON response.
    return {
        "statusCode": 200,
        "body": json.dumps(
            comments
        )
    }