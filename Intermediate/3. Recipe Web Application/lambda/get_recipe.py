import os
import json
import logging
import boto3
from decimal import Decimal

logger = logging.getLogger()
logger.setLevel(logging.INFO)

TABLE_NAME = os.environ["TABLE_NAME"]

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(TABLE_NAME)


def handler(event, context):
    try:
        logger.info("Fetching recipes")

        response_db = table.scan()
        items = response_db.get("Items", [])

        while "LastEvaluatedKey" in response_db:
            response_db = table.scan(
                ExclusiveStartKey=response_db["LastEvaluatedKey"]
            )
            items.extend(response_db.get("Items", []))

        return {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*"
            },
            "body": json.dumps(items, default=_decimal_serializer)
        }

    except Exception as e:
        logger.exception("Error fetching recipes")
        return {
            "statusCode": 500,
            "body": json.dumps({"error": "Failed to fetch recipes"})
        }


def _decimal_serializer(obj):
    if isinstance(obj, Decimal):
        return int(obj)
    raise TypeError
