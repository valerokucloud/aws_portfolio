import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def handler(event, context):
    """
    Authentication test endpoint.
    Validates that the request has passed the JWT authorizer.
    """

    logger.info("Authentication token validated successfully")

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*"
        },
        "body": json.dumps({
            "message": "Authentication successful"
        })
    }
