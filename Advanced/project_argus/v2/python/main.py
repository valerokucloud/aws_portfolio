import time
from motion import MotionDetector
from capture import save_frame
from upload import upload_image
from rekognition import analyze_image
from pattern_engine import get_interesting_detections
from logger_config import logger
from notify import NotificationService


"""
Main orchestration module.

This module coordinates the complete Argus workflow without implementing
business logic.

Workflow:

1. Detect motion.
2. Capture the current frame.
3. Encode the image in memory.
4. Upload the image to Amazon S3.
5. Analyze the image with Amazon Rekognition.
6. Filter the detections using the Pattern Engine.
7. Send a notification through Amazon SNS.
"""

def main():

    logger.info("🚀 Starting Argus...")

    # Start movement detection and camera RTSP connection:
    detector = MotionDetector()
    notification_service = NotificationService()

    try:

        while True:
            # Wait until OpenCV detect movement:
            motion_detected, frame = detector.detect_motion()

            # If no motion has been detected, we continue recording:
            if not motion_detected:
                continue

            # Else: print message + saving frame returning the path:
            logger.info("────────────────────────────────")
            logger.info("🚨 Motion detected.")
            image_bytes = save_frame(frame)

            # If the image could not be encoded --> return to continue recording:
            if image_bytes is None:
                continue
           
            # Try to upload the image to S3 bucket:
            s3_key = upload_image(image_bytes)
            if s3_key is None:
                continue
            
            # Else (image uploaded)
            logger.info(
            f"☁️ Image uploaded to S3 | key={s3_key}"
            )

            # Calling the function:
            detections = analyze_image(s3_key)
            logger.info(
                f"🤖 Rekognition analysis completed | detections={len(detections)}"
            )

            # Obtaining only the detections considered relevant:
            interesting_detections = get_interesting_detections(detections)
            logger.info(
                f"🎯 Interesting objects | count={len(interesting_detections)}"
            )

            # If the movement recognized != list:
            if not interesting_detections:

                logger.info("ℹ️ No interesting objects detected.")

                time.sleep(3)
                continue

            logger.info("🤖 Objects detected:")

            # Browsing the list:
            for detection in interesting_detections:

                logger.info(
                    f"🎯 {detection['label']} | "
                    f"confidence={detection['confidence']:.2f}%"
            )

            # Sending one SNS notification for the whole event:
            notification_service.send_notification(
                detections=interesting_detections,
                s3_key=s3_key
            )

            # Short delay
            time.sleep(3)

    except KeyboardInterrupt:

        logger.info("🛑 Argus halted by the user.")

    finally:

        detector.release()


if __name__ == "__main__":

    main()