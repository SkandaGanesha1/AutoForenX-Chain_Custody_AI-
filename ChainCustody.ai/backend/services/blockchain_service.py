from web3 import Web3

class BlockchainService:
    def __init__(self):
        self.web3 = Web3(Web3.HTTPProvider("http://127.0.0.1:8545"))  # Connect to local blockchain
        self.contract_address = "0xYourContractAddressHere"  # Replace with actual contract address
        self.contract_abi = [...]  # Replace with actual ABI
        self.contract = self.web3.eth.contract(address=self.contract_address, abi=self.contract_abi)

    def collect_evidence(self, ipfs_hash, location):
        """
        Records evidence metadata on the blockchain.
        :param ipfs_hash: IPFS hash of the evidence file.
        :param location: Geolocation of evidence collection.
        :return: Evidence ID.
        """
        tx_hash = self.contract.functions.collectEvidence(
            ipfs_hash, location
        ).transact({"from": self.web3.eth.accounts[0]})
        receipt = self.web3.eth.waitForTransactionReceipt(tx_hash)
        return receipt.logs[0]["args"]["id"]

    def get_evidence(self, evidence_id):
        """
        Retrieves evidence metadata from the blockchain.
        :param evidence_id: Unique identifier for the evidence.
        :return: Evidence details.
        """
        evidence = self.contract.functions.evidenceRecords(evidence_id).call()
        return {
            "id": evidence[0],
            "hash": evidence[1],
            "timestamp": evidence[2],
            "collector": evidence[3],
            "location": evidence[4],
            "isTampered": evidence[5]
        }