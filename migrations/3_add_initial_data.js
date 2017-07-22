var Depot = artifacts.require("./Depot.sol");

module.exports = function(deployer) {
  Depot.deployed()
    .then((instance) => {
      instance.addWarehouse(100, 1, true, 'STL', 'MEM');
      return instance;
    })
    .then((instance) => {
      instance.addWarehouse(100, 1, true, 'STL', 'STL');
    });
};
