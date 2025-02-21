from functools import wraps
from flask import request, jsonify

def authenticate_user(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        # Simulate biometric authentication
        auth_header = request.headers.get("Authorization")
        if not auth_header or auth_header != "BiometricToken123":
            return jsonify({"error": "Unauthorized"}), 401
        return f(*args, **kwargs)
    return decorated_function