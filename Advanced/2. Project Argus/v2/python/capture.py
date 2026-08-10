import cv2
from logger_config import logger

# Convert an OpenCV frame into JPEG bytes
def save_frame(frame):
    
    # Capture the frame and saving it to JPEG in memory
    success, buffer = cv2.imencode(".jpg", frame)
 
    if not success:

        logger.warning("❌ Could not encode the frame")
        return None

    # Return the JPEG image as bytes + prompt image size:
    image_bytes = buffer.tobytes()
    logger.info(
        f"📸 Image encoded | size={len(image_bytes) / 1024:.1f} KB"
    )
    return image_bytes