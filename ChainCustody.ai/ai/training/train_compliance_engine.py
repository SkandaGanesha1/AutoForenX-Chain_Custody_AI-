from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.pipeline import make_pipeline
import joblib

# Simulated dataset: Texts represent legal documents
texts = [
    "Evidence must be stored securely.",
    "Chain of custody must be documented.",
    "Unauthorized access is prohibited."
]
labels = ["compliant", "compliant", "non-compliant"]

# Build a text classification pipeline
model = make_pipeline(TfidfVectorizer(), MultinomialNB())

# Train the model
model.fit(texts, labels)

# Save the trained model
joblib.dump(model, "../models/compliance_engine_model.pkl")