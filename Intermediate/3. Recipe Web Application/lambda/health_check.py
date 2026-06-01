import logging
from utils import response

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def handler(event, context):
    logger.info("Health check requested")
    return response(200, {"status": "healthy"})
