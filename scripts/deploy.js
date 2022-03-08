const hre = require("hardhat");

async function main() {
  const pichiContract = await hre.ethers.getContractFactory("PichiNFT");
  const pichiContractDeploy = await pichiContract.deploy();

  await pichiContractDeploy.deployed();

  console.log("Pichi deployed to:", pichiContractDeploy.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
