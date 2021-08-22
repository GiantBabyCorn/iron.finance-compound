const ironCompound = artifacts.require("ironCompound");

module.exports = async function(deployer, network, accounts) {
  deployer.deploy(ironCompound);
};
