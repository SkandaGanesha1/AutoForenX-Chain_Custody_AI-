// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/**
 * @title SmartEvidenceContract
 * @dev A smart contract for managing self-sovereign evidence in the ChronoOmni Nexus system.
 * Each piece of evidence is represented as a unique NFT with secure access control,
 * biometric validation, and quantum-entangled anchoring.
 */
contract SmartEvidenceContract is ERC721, Ownable, ReentrancyGuard {
    using ECDSA for bytes32;

    // Struct to represent an evidence pod
    struct EvidencePod {
        uint256 tokenId; // Unique identifier for the pod
        string metadataURI; // IPFS or decentralized storage URI for evidence
        address creator; // Address of the pod creator
        uint256 creationTime; // Timestamp of pod creation
        uint256 lastAccessTime; // Timestamp of last access
        bool isLocked; // Whether the pod is locked for modifications
        mapping(address => bool) authorizedUsers; // Users authorized to access the pod
        string quantumAnchor; // Quantum-entangled anchor for spatial-temporal validation
    }

    // Mapping from token ID to EvidencePod
    mapping(uint256 => EvidencePod) private evidencePods;

    // Biometric oracle for validating user signatures
    address public biometricOracle;

    // Event logs for transparency
    event PodCreated(uint256 indexed tokenId, address indexed creator, string metadataURI);
    event PodAccessed(uint256 indexed tokenId, address indexed accessor, uint256 timestamp);
    event PodLocked(uint256 indexed tokenId, address indexed locker);
    event PodUnlocked(uint256 indexed tokenId, address indexed unlocker);
    event PodQuantumAnchored(uint256 indexed tokenId, string quantumAnchor);

    // Constructor
    constructor(string memory name, string memory symbol, address _biometricOracle)
        ERC721(name, symbol)
    {
        require(_biometricOracle != address(0), "Invalid biometric oracle address");
        biometricOracle = _biometricOracle;
    }

    /**
     * @dev Creates a new evidence pod.
     * @param metadataURI The URI pointing to the evidence metadata (e.g., IPFS hash).
     * @param quantumAnchor The quantum-entangled anchor for spatial-temporal validation.
     * @param signature Biometric signature of the creator for validation.
     */
    function createPod(
        string calldata metadataURI,
        string calldata quantumAnchor,
        bytes calldata signature
    ) external nonReentrant {
        require(bytes(metadataURI).length > 0, "Metadata URI cannot be empty");
        require(bytes(quantumAnchor).length > 0, "Quantum anchor cannot be empty");

        // Validate biometric signature
        require(
            isValidSignature(msg.sender, metadataURI, signature),
            "Invalid biometric signature"
        );

        // Mint a new NFT representing the pod
        uint256 tokenId = totalSupply() + 1;
        _safeMint(msg.sender, tokenId);

        // Initialize the pod
        EvidencePod storage pod = evidencePods[tokenId];
        pod.tokenId = tokenId;
        pod.metadataURI = metadataURI;
        pod.creator = msg.sender;
        pod.creationTime = block.timestamp;
        pod.lastAccessTime = block.timestamp;
        pod.isLocked = false;
        pod.quantumAnchor = quantumAnchor;

        emit PodCreated(tokenId, msg.sender, metadataURI);
        emit PodQuantumAnchored(tokenId, quantumAnchor);
    }

    /**
     * @dev Grants access to a specific user for a pod.
     * @param tokenId The ID of the evidence pod.
     * @param user The address of the user to authorize.
     */
    function grantAccess(uint256 tokenId, address user) external onlyOwnerOf(tokenId) {
        require(user != address(0), "Invalid user address");
        evidencePods[tokenId].authorizedUsers[user] = true;
    }

    /**
     * @dev Revokes access from a specific user for a pod.
     * @param tokenId The ID of the evidence pod.
     * @param user The address of the user to revoke access from.
     */
    function revokeAccess(uint256 tokenId, address user) external onlyOwnerOf(tokenId) {
        require(user != address(0), "Invalid user address");
        evidencePods[tokenId].authorizedUsers[user] = false;
    }

    /**
     * @dev Locks the pod to prevent further modifications.
     * @param tokenId The ID of the evidence pod.
     */
    function lockPod(uint256 tokenId) external onlyOwnerOf(tokenId) {
        evidencePods[tokenId].isLocked = true;
        emit PodLocked(tokenId, msg.sender);
    }

    /**
     * @dev Unlocks the pod to allow modifications.
     * @param tokenId The ID of the evidence pod.
     */
    function unlockPod(uint256 tokenId) external onlyOwnerOf(tokenId) {
        evidencePods[tokenId].isLocked = false;
        emit PodUnlocked(tokenId, msg.sender);
    }

    /**
     * @dev Accesses the metadata of a pod.
     * @param tokenId The ID of the evidence pod.
     * @return The metadata URI of the pod.
     */
    function accessPod(uint256 tokenId) external view returns (string memory) {
        EvidencePod storage pod = evidencePods[tokenId];
        require(pod.authorizedUsers[msg.sender] || msg.sender == pod.creator, "Unauthorized access");
        return pod.metadataURI;
    }

    /**
     * @dev Updates the metadata URI of a pod (only if unlocked).
     * @param tokenId The ID of the evidence pod.
     * @param newMetadataURI The new metadata URI.
     */
    function updatePodMetadata(uint256 tokenId, string calldata newMetadataURI)
        external
        onlyOwnerOf(tokenId)
    {
        EvidencePod storage pod = evidencePods[tokenId];
        require(!pod.isLocked, "Pod is locked");
        pod.metadataURI = newMetadataURI;
    }

    /**
     * @dev Validates a biometric signature using an oracle.
     * @param signer The address of the signer.
     * @param data The data signed by the user.
     * @param signature The biometric signature.
     * @return True if the signature is valid, false otherwise.
     */
    function isValidSignature(
        address signer,
        string memory data,
        bytes memory signature
    ) internal view returns (bool) {
        bytes32 messageHash = keccak256(abi.encodePacked(data)).toEthSignedMessageHash();
        address recoveredSigner = messageHash.recover(signature);
        return recoveredSigner == signer && recoveredSigner == biometricOracle;
    }

    /**
     * @dev Modifier to restrict access to the owner of a specific pod.
     */
    modifier onlyOwnerOf(uint256 tokenId) {
        require(ownerOf(tokenId) == msg.sender, "Not the owner of this pod");
        _;
    }
}