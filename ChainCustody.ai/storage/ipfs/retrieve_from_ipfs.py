import ipfshttpclient
from storage.encryption.decrypt_file import decrypt_file

def retrieve_from_ipfs(ipfs_hash, output_path, key):
    """
    Retrieves a file from IPFS and decrypts it.
    :param ipfs_hash: IPFS hash of the file.
    :param output_path: Path to save the decrypted file.
    :param key: Encryption key.
    :return: Path to the decrypted file.
    """
    client = ipfshttpclient.connect("/ip4/127.0.0.1/tcp/5001")  # Connect to local IPFS node
    client.get(ipfs_hash)  # Download the file
    encrypted_file_path = ipfs_hash
    decrypted_file_path = decrypt_file(encrypted_file_path, key)
    return decrypted_file_path

# Example usage
if __name__ == "__main__":
    ipfs_hash = "QmExampleHash"  # Replace with actual IPFS hash
    key = b"your_encryption_key_here"  # Replace with actual key
    decrypted_file = retrieve_from_ipfs(ipfs_hash, "retrieved_evidence.txt", key)
    print("Decrypted File:", decrypted_file)