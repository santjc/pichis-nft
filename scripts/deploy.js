const hre = require("hardhat");

async function main() {
  const PichiNFT = await hre.ethers.getContractFactory("PichiNFT");
  const PichiNFT = await Characters.deploy();

  await PichiNFT.deployed();

  console.log("Character deployed to:", PichiNFT.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
