import numpy as np
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Dropout, BatchNormalization
from tensorflow.keras.callbacks import EarlyStopping, TensorBoard
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report, confusion_matrix
import os
import datetime

# Step 1: Simulated Dataset with Meaningful Patterns
np.random.seed(42)
X = np.random.rand(1000, 5)  # 1000 samples, 5 features
y = ((X[:, 0] + X[:, 1]) > 1.0).astype(int)  # Label depends on the sum of the first two features

# Split into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Step 2: Build an Advanced Neural Network
model = Sequential([
    Dense(32, activation="relu", input_shape=(5,)),  # Larger input layer
    BatchNormalization(),  # Normalize activations
    Dropout(0.3),  # Regularization to prevent overfitting
    Dense(16, activation="relu"),
    BatchNormalization(),
    Dropout(0.3),
    Dense(8, activation="relu"),
    Dense(1, activation="sigmoid")  # Output layer for binary classification
])

# Compile the model
model.compile(optimizer="adam", loss="binary_crossentropy", metrics=["accuracy"])

# Step 3: Callbacks for Early Stopping and TensorBoard Logging
log_dir = os.path.join("logs", "fit", datetime.datetime.now().strftime("%Y%m%d-%H%M%S"))
tensorboard_callback = TensorBoard(log_dir=log_dir, histogram_freq=1)
early_stopping_callback = EarlyStopping(monitor="val_loss", patience=5, restore_best_weights=True)

# Step 4: Train the Model
history = model.fit(
    X_train, y_train,
    epochs=50,  # More epochs with early stopping
    batch_size=32,
    validation_data=(X_test, y_test),
    callbacks=[tensorboard_callback, early_stopping_callback]
)

# Step 5: Evaluate the Model
test_loss, test_accuracy = model.evaluate(X_test, y_test)
print(f"Test Loss: {test_loss:.4f}, Test Accuracy: {test_accuracy:.4f}")

# Predictions
y_pred = (model.predict(X_test) > 0.5).astype(int)

# Classification Report
print("\nClassification Report:")
print(classification_report(y_test, y_pred))

# Confusion Matrix
print("Confusion Matrix:")
print(confusion_matrix(y_test, y_pred))

# Step 6: Save the Trained Model
model.save("../models/tampering_detection_model.h5")
print("\nModel saved successfully.")