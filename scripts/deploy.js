const hre = require("hardhat");

async function main() {
  const Characters = await hre.ethers.getContractFactory("Characters");
  const character = await Characters.deploy();

  await character.deployed();

  console.log("Character deployed to:", character.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
