const hre = require("hardhat");

async function main() {
    console.log("Deploying AgentVault contract...");

    const agentVault = await hre.ethers.deployContract("AgentVault");

    await agentVault.waitForDeployment();

    console.log(`AgentVault successfully deployed to: ${await agentVault.getAddress()}`);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
