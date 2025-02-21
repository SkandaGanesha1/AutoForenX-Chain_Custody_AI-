import os
import hashlib
import numpy as np
from tensorflow.keras.models import load_model
from datetime import datetime

# Utility function to compute file hash
def compute_file_hash(file_path):
    """
    Computes the SHA-256 hash of a file.
    :param file_path: Path to the file.
    :return: Hexadecimal hash string.
    """
    sha256_hash = hashlib.sha256()
    with open(file_path, "rb") as f:
        for byte_block in iter(lambda: f.read(4096), b""):
            sha256_hash.update(byte_block)
    return sha256_hash.hexdigest()

# Utility function to extract file features
def extract_file_features(file_path):
    """
    Extracts features from a file for anomaly detection.
    :param file_path: Path to the file.
    :return: List of numerical features.
    """
    # Feature 1: File size
    file_size = os.path.getsize(file_path)

    # Feature 2: File hash (convert to integer representation)
    file_hash = compute_file_hash(file_path)
    hash_int = int(file_hash[:8], 16)  # Use first 8 characters of hash as an integer

    # Feature 3: Creation timestamp (normalized to days since epoch)
    creation_time = os.path.getctime(file_path)
    creation_days = (datetime.fromtimestamp(creation_time) - datetime(1970, 1, 1)).days

    # Feature 4: Modification timestamp (normalized to days since epoch)
    modification_time = os.path.getmtime(file_path)
    modification_days = (datetime.fromtimestamp(modification_time) - datetime(1970, 1, 1)).days

    # Feature 5: Random noise (simulated feature for demonstration)
    random_noise = np.random.rand()

    # Return features as a list
    return [file_size, hash_int, creation_days, modification_days, random_noise]

# Anomaly detection function
def detect_anomalies(file_path, model_path="../models/tampering_detection_model.h5"):
    """
    Detects anomalies (e.g., tampering) in a file using a pre-trained model.
    :param file_path: Path to the file.
    :param model_path: Path to the pre-trained anomaly detection model.
    :return: Prediction (0 = No anomaly, 1 = Anomaly detected).
    """
    try:
        # Load the pre-trained model
        model = load_model(model_path)

        # Extract features from the file
        features = extract_file_features(file_path)

        # Normalize features (optional, depending on model requirements)
        features = np.array(features).reshape(1, -1)  # Reshape for model input

        # Predict anomaly
        prediction = model.predict(features)
        anomaly_detected = int(prediction[0][0] > 0.5)

        # Log the result
        log_result(file_path, anomaly_detected)

        return anomaly_detected

    except Exception as e:
        print(f"Error during anomaly detection: {e}")
        return None

# Logging function
def log_result(file_path, anomaly_detected):
    """
    Logs the anomaly detection result for auditing purposes.
    :param file_path: Path to the file.
    :param anomaly_detected: Prediction (0 = No anomaly, 1 = Anomaly detected).
    """
    log_message = f"[{datetime.now()}] File: {file_path}, Anomaly Detected: {'Yes' if anomaly_detected else 'No'}\n"
    with open("../logs/anomaly_detection.log", "a") as log_file:
        log_file.write(log_message)

# Example usage
if __name__ == "__main__":
    file_path = "../example_evidence.txt"  # Replace with actual file path
    anomaly_detected = detect_anomalies(file_path)
    if anomaly_detected is not None:
        print("Anomaly Detected:", anomaly_detected)