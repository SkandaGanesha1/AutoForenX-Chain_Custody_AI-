import joblib

def analyze_compliance(text):
    """
    Analyzes whether a legal document complies with regulations.
    :param text: Legal document text.
    :return: Prediction ("compliant" or "non-compliant").
    """
    model = joblib.load("../models/compliance_engine_model.pkl")
    return model.predict([text])[0]

# Example usage
if __name__ == "__main__":
    text = "Evidence must be encrypted."
    print("Compliance Status:", analyze_compliance(text))