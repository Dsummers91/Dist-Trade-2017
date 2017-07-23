var Depot = artifacts.require("./Depot.sol");

module.exports = function(deployer) {
  Depot.deployed()
    .then((instance) => {
      instance.addWarehouse(1000, 1, 'STL', 'STL', {from: web3.eth.accounts[3]});
      return instance;
    })
    .then((instance) => {
      instance.addWarehouse(2500, 1, 'STL', 'STL', {from: web3.eth.accounts[1]});
      return instance;
    })
    .then((instance) => {
      instance.addWarehouse(1000, 1, 'MEM', 'MEM', {from: web3.eth.accounts[2]});
      return instance;
    })
    .then((instance) => {
      instance.addWarehouse(10000, 1, 'SHA', 'SHA', {from: web3.eth.accounts[4]});
      return instance;
    })
    .then((instance) => {
      instance.addWarehouse(10000, 11, 'NSH', 'NSH', {from: web3.eth.accounts[5]});
      return instance;
    })

    // DEPLOY VEHICLES
    .then((instance) => {
      instance.addVehicle(1000, 8, 'STL', 'MEM', {from: web3.eth.accounts[3]});
      return instance;
    })
    .then((instance) => {
      instance.addVehicle(2500, 8, 'STL', 'CHI', {from: web3.eth.accounts[1]});
      return instance;
    })
    .then((instance) => {
      instance.addVehicle(1000, 8, 'MEM', 'NO', {from: web3.eth.accounts[2]});
      return instance;
    })
    .then((instance) => {
      instance.addVehicle(10000, 8, 'MEM', 'SHA', {from: web3.eth.accounts[4]});
      return instance;
    })
    .then((instance) => {
      instance.addVehicle(10000, 8, 'SHA', 'NY', {from: web3.eth.accounts[5]});
    });
};
