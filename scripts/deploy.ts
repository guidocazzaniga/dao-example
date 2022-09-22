// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { ethers } from "hardhat";

async function main() {

  const Token = await ethers.getContractFactory("GovernanceToken");
  const token = await Token.deploy();

  await token.deployed();

  console.log("Token deployed to:", token.address);
  
  const Governor = await ethers.getContractFactory("MyGovernor");
  const governor = await Governor.deploy(token.address);

  await governor.deployed();

  console.log("Governor deployed to:", governor.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
