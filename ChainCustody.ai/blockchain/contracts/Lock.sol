// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SmartEvidenceContract {
    struct Evidence {
        string id; // Unique identifier for the evidence
        string hash; // Cryptographic hash of the evidence file
        uint256 timestamp; // Timestamp of evidence collection
        address collector; // Address of the person who collected the evidence
        string location; // Geolocation of evidence collection
        bool isTampered; // Flag to indicate tampering
    }

    mapping(string => Evidence) public evidenceRecords; // Map evidence ID to its details

    event EvidenceCollected(string id, string hash, uint256 timestamp, address collector, string location);
    event EvidenceTampered(string id);

    // Function to record evidence on the blockchain
    function collectEvidence(
        string memory _id,
        string memory _hash,
        string memory _location
    ) public {
        require(bytes(evidenceRecords[_id].id).length == 0, "Evidence ID already exists");
        evidenceRecords[_id] = Evidence({
            id: _id,
            hash: _hash,
            timestamp: block.timestamp,
            collector: msg.sender,
            location: _location,
            isTampered: false
        });
        emit EvidenceCollected(_id, _hash, block.timestamp, msg.sender, _location);
    }

    // Function to flag evidence as tampered
    function flagAsTampered(string memory _id) public {
        require(bytes(evidenceRecords[_id].id).length > 0, "Evidence ID does not exist");
        evidenceRecords[_id].isTampered = true;
        emit EvidenceTampered(_id);
    }
}