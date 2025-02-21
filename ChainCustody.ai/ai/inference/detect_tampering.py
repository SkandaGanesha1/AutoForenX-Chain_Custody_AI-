import numpy as np
from tensorflow.keras.models import load_model

def detect_tampering(features):
    """
    Detects tampering in evidence files using a pre-trained model.
    :param features: List of file features (e.g., size, timestamps).
    :return: Prediction (0 = Untampered, 1 = Tampered).
    """
    model = load_model("../models/tampering_detection_model.h5")
    prediction = model.predict(np.array([features]))
    return int(prediction[0][0] > 0.5)

# Example usage
if __name__ == "__main__":
    features = [0.1, 0.5, 0.3, 0.7, 0.2]  # Replace with actual file features
    print("Tampering Detected:", detect_tampering(features))