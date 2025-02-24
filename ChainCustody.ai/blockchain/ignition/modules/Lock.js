const { ethers } = require("hardhat");

async function main() {
    const SmartEvidenceContract = await ethers.getContractFactory("SmartEvidenceContract");
    const smartEvidence = await SmartEvidenceContract.deploy();

    await smartEvidence.waitForDeployment();

    console.log(`SmartEvidenceContract deployed to: ${await smartEvidence.getAddress()}`);
}

// Run the script
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
