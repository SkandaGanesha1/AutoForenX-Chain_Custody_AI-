import hashlib

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

# Example usage
if __name__ == "__main__":
    file_path = "example_evidence.txt"
    print("File Hash:", compute_file_hash(file_path))