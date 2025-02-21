import ipfshttpclient

def upload_to_ipfs(file_path):
    """
    Uploads a file to IPFS.
    :param file_path: Path to the file.
    :return: IPFS hash of the uploaded file.
    """
    client = ipfshttpclient.connect("/ip4/127.0.0.1/tcp/5001")  # Connect to local IPFS node
    res = client.add(file_path)
    return res["Hash"]

# Example usage
if __name__ == "__main__":
    file_path = "example_evidence.txt.enc"  # Encrypted file
    ipfs_hash = upload_to_ipfs(file_path)
    print("IPFS Hash:", ipfs_hash)