from flask import Flask, request, jsonify
from services.blockchain_service import BlockchainService
from services.ai_service import AIService
from services.storage_service import StorageService

app = Flask(__name__)

# Initialize services
blockchain_service = BlockchainService()
ai_service = AIService()
storage_service = StorageService()

@app.route('/collect-evidence', methods=['POST'])
def collect_evidence():
    """
    API endpoint to collect and store evidence.
    """
    file = request.files['file']
    location = request.form['location']
    
    # Save the file temporarily
    file_path = f"temp/{file.filename}"
    file.save(file_path)
    
    # Store evidence in decentralized storage
    ipfs_hash = storage_service.store_evidence(file_path)
    
    # Record evidence metadata on the blockchain
    evidence_id = blockchain_service.collect_evidence(ipfs_hash, location)
    
    return jsonify({"evidence_id": evidence_id, "ipfs_hash": ipfs_hash}), 201

@app.route('/verify-evidence/<evidence_id>', methods=['GET'])
def verify_evidence(evidence_id):
    """
    API endpoint to verify evidence integrity.
    """
    # Retrieve evidence metadata from the blockchain
    evidence = blockchain_service.get_evidence(evidence_id)
    
    # Verify integrity using AI
    is_valid = ai_service.verify_evidence_integrity(evidence["file_path"], evidence["hash"])
    
    return jsonify({"evidence_id": evidence_id, "is_valid": is_valid}), 200

if __name__ == "__main__":
    app.run(debug=True)