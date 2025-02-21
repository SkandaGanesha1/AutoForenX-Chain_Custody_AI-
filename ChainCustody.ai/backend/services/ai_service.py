from ai.inference.detect_tampering import detect_tampering
from ai.utils.file_hashing import compute_file_hash

class AIService:
    def verify_evidence_integrity(self, file_path, expected_hash):
        """
        Verifies the integrity of an evidence file.
        :param file_path: Path to the evidence file.
        :param expected_hash: Hash stored on the blockchain.
        :return: True if integrity is verified, False otherwise.
        """
        actual_hash = compute_file_hash(file_path)
        if actual_hash != expected_hash:
            return False
        
        # Simulate tampering detection
        features = [0.1, 0.5, 0.3, 0.7, 0.2]  # Replace with actual features
        tampering_detected = detect_tampering(features)
        return not tampering_detected