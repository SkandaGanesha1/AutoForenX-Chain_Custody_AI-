const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("SmartEvidenceContract", function () {
    let SmartEvidenceContract;
    let smartEvidence;
    let owner, addr1;

    before(async function () {
        [owner, addr1] = await ethers.getSigners();
        SmartEvidenceContract = await ethers.getContractFactory("SmartEvidenceContract");
        smartEvidence = await SmartEvidenceContract.deploy();
        await smartEvidence.waitForDeployment();
    });

    it("should allow collecting evidence", async function () {
        const evidenceId = "evidence_001";
        const evidenceHash = "abc123";
        const location = "New York";

        await smartEvidence.collectEvidence(evidenceId, evidenceHash, location);

        const evidence = await smartEvidence.evidenceRecords(evidenceId);

        expect(evidence.id).to.equal(evidenceId);
        expect(evidence.hash).to.equal(evidenceHash);
        expect(evidence.location).to.equal(location);
    });

    it("should flag evidence as tampered", async function () {
        const evidenceId = "evidence_001";

        await smartEvidence.flagAsTampered(evidenceId);

        const evidence = await smartEvidence.evidenceRecords(evidenceId);
        expect(evidence.isTampered).to.equal(true);
    });
});
