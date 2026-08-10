import time
import cv2
import config

from logger_config import logger


# Class creation (need to save info like camera config, last frame):
class MotionDetector:

    def __init__(self):

        # Open the RTSP connection only once:
        self.cap = cv2.VideoCapture(config.CAMERA_RTSP)

        if not self.cap.isOpened():
            logger.error("Unable to open RTSP camera.")
            raise ConnectionError()

        # Previous frame used to detect movement (frame differences)
        self.previous_frame = None


    # Reconnect to the RTSP camera after a connection loss:
    def _reconnect(self):

        max_attempts = 3
        logger.warning("RTSP connection lost.")

        # Close the current RTSP connection:
        self.cap.release()

        # Try to reconnect several times:
        for attempt in range(1, max_attempts + 1):

            logger.info(
                f"Reconnect attempt {attempt}/{max_attempts}..."
            )

            time.sleep(2)

            self.cap = cv2.VideoCapture(config.CAMERA_RTSP)

            if self.cap.isOpened():

                logger.info("RTSP connection restored.")

                # Reset previous frame to avoid false detections:
                self.previous_frame = None

                return True

        logger.error("Unable to reconnect to the RTSP camera.")

        return False

    # Read a video frame:
    def get_frame(self):

        ret, frame = self.cap.read()

        if ret:
            return True, frame

        logger.warning("Unable to read a frame from the RTSP stream.")

        # Try to reconnect to the RTSP camera:
        if not self._reconnect():
            return False, None

        # Try reading a frame again:
        ret, frame = self.cap.read()

        if not ret:

            logger.error(
                "Unable to read a frame after reconnecting."
            )

            return False, None

        return True, frame

    # Detect motion comparing current frame vs previous one:
    def detect_motion(self):

        success, frame = self.get_frame()

        if not success:
            return False, None

        # Convert the frame to grayscale to simplify the comparison process
        # and reduce the amount of image data to analyze.
        gray = cv2.cvtColor(
            frame,
            cv2.COLOR_BGR2GRAY
        )

        #  Applying GaussianBlur before comparing frames to reduce image noise and small pixel variations
        gray = cv2.GaussianBlur(
            gray,
            (21, 21),
            0
        )

        # Store the first frame as the reference frame. Motion detection
        # starts from the second frame onwards.
        if self.previous_frame is None:

            self.previous_frame = gray

            return False, frame

        # Calculate the absolute difference between the current frame
        # and the previous one.
        difference = cv2.absdiff(
            self.previous_frame,
            gray
        )

        # Convert the difference image into a binary image where moving
        # areas become white and unchanged areas remain black.
        threshold = cv2.threshold(
            difference,
            25,
            255,
            cv2.THRESH_BINARY
        )[1]

        # Expand the detected regions to fill small gaps and improve
        # contour detection.
        threshold = cv2.dilate(
            threshold,
            None,
            iterations=2
        )

        # Detect all moving regions (contours) in the processed image.
        contours, _ = cv2.findContours(
            threshold,
            cv2.RETR_EXTERNAL,
            cv2.CHAIN_APPROX_SIMPLE
        )

        # Update the reference frame for the next comparison.
        self.previous_frame = gray

        # Browse all detected contours:
        for contour in contours:

             # Ignore small contours to reduce false positives caused by
            # image noise, lighting changes or insignificant movements.
            # The threshold was experimentally selected for this camera setup.
            if cv2.contourArea(contour) > 5000:

                return True, frame

        return False, frame

    # Release RTSP connection when closing Argus
    def release(self):

        self.cap.release()