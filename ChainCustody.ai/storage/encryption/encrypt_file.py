from cryptography.fernet import Fernet

def generate_key():
    """
    Generates a symmetric encryption key.
    :return: Key as bytes.
    """
    return Fernet.generate_key()

def encrypt_file(file_path, key):
    """
    Encrypts a file using the provided key.
    :param file_path: Path to the file.
    :param key: Encryption key.
    :return: Path to the encrypted file.
    """
    cipher = Fernet(key)
    with open(file_path, "rb") as f:
        data = f.read()
    encrypted_data = cipher.encrypt(data)
    encrypted_file_path = file_path + ".enc"
    with open(encrypted_file_path, "wb") as f:
        f.write(encrypted_data)
    return encrypted_file_path

def decrypt_file(encrypted_file_path, key):
    """
    Decrypts a file using the provided key.
    :param encrypted_file_path: Path to the encrypted file.
    :param key: Encryption key.
    :return: Path to the decrypted file.
    """
    cipher = Fernet(key)
    with open(encrypted_file_path, "rb") as f:
        encrypted_data = f.read()
    decrypted_data = cipher.decrypt(encrypted_data)
    decrypted_file_path = encrypted_file_path.replace(".enc", "")
    with open(decrypted_file_path, "wb") as f:
        f.write(decrypted_data)
    return decrypted_file_path

# Example usage
if __name__ == "__main__":
    key = generate_key()
    encrypted_file = encrypt_file("example_evidence.txt", key)
    print("Encrypted File:", encrypted_file)
    decrypted_file = decrypt_file(encrypted_file, key)
    print("Decrypted File:", decrypted_file)