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

        table.delete_item(
            Key={"id": recipe_id}
        )

        logger.info("Recipe deleted: %s", recipe_id)
        return {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*"
            },
            "body": json.dumps({"message": "Recipe deleted"})
        }

    except Exception as e:
        logger.exception("Error deleting recipe")
        return {
            "statusCode": 500,
            "body": json.dumps({"error": "Failed to delete recipe"})
        }
