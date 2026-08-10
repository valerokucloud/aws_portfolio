import logging

# LOG (INFO | WARN | ERROR) configuration:
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s | %(levelname)s | %(message)s"
)

logger = logging.getLogger("argus")