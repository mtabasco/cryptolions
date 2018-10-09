var LionFactory = artifacts.require("./lionfactory.sol");
var LionFeeding = artifacts.require("./lionfeeding.sol");
var LionHelper = artifacts.require("./lionhelper.sol");
var LionOwnership = artifacts.require("./lionownership.sol");

module.exports = function(deployer) {
  deployer.deploy(LionFactory);
  deployer.deploy(LionFeeding);
  deployer.deploy(LionHelper);
  deployer.deploy(LionOwnership);
};
