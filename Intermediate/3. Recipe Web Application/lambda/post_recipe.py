import json
import boto3
import uuid

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table("Recipes")

def handler(event, context):
    print("EVENT:", event)

    # API Gateway siempre manda body (string)
    body = json.loads(event["body"])

    item = {
        "recipeId": str(uuid.uuid4()),
        "name": body["name"],
        "likes": 0
    }

    table.put_item(Item=item)

    return {
        "statusCode": 201,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*"
        },
        "body": json.dumps(item)
    }

