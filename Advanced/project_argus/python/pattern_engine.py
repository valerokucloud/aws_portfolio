INTERESTING_LABELS = {
    "Person",
    "Robot",
    "Vacuum Cleaner"
}


def get_interesting_detections(detections):
    
    # Return only the detections considered relevant for Argus.
    
    interesting = []

    # Filtering (listing) the complete Rekognition response to retain only the relevant labels 
    for detection in detections:
        if detection["label"] in INTERESTING_LABELS:
            interesting.append(detection)

    return interesting


def is_interesting(detections):
    # Return True if at least one interesting detection is found.
    return len(get_interesting_detections(detections)) > 0