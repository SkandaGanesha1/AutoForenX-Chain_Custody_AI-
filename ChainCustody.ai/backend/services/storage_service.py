from storage.ipfs.upload_to_ipfs import upload_to_ipfs
from storage.encryption.encrypt_file import encrypt_file

class StorageService:
    def store_evidence(self, file_path):
        """
        Stores an evidence file in decentralized storage.
        :param file_path: Path to the evidence file.
        :return: IPFS hash of the stored file.
        """
        # Encrypt the file
        key = b"your_encryption_key_here"  # Replace with actual key
        encrypted_file_path = encrypt_file(file_path, key)
        
        # Upload to IPFS
        ipfs_hash = upload_to_ipfs(encrypted_file_path)
        return ipfs_hash