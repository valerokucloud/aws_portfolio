import os
import json
import logging
import boto3

logger = logging.getLogger()
logger.setLevel(logging.INFO)

TABLE_NAME = os.environ["TABLE_NAME"]

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(TABLE_NAME)


def handler(event, context):
    try:
        recipe_id = event["pathParameters"]["recipe_id"]

        table.update_item(
            Key={"id": recipe_id},
            UpdateExpression="SET likes = if_not_exists(likes, :zero) + :inc",
            ExpressionAttributeValues={
                ":inc": 1,
                ":zero": 0
            }
        )

        logger.info("Recipe liked: %s", recipe_id)
        return {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*"
            },
            "body": json.dumps({"message": "Recipe liked"})
        }

    except Exception as e:
        logger.exception("Error liking recipe")
        return {
            "statusCode": 500,
            "body": json.dumps({"error": "Failed to like recipe"})
        }
