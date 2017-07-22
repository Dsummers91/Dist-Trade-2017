var Depot = artifacts.require("./Depot.sol");

module.exports = function(deployer) {
  Depot.deployed()
    .then((instance) => {
      instance.addWarehouse(1000, 10, true);
    });
};
