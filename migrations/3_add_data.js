var Depot = artifacts.require("./Depot.sol");
var moment = require('moment');

module.exports = function(deployer) {
  Depot.deployed()
    .then((instance) => {
      instance.addWarehouse(1000, 4, 'STL', 'STL', {from: web3.eth.accounts[3]});
      return instance;
    })
    .then((instance) => {
      instance.addWarehouse(2500, 4, 'STL', 'STL', {from: web3.eth.accounts[1]});
      return instance;
    })
    .then((instance) => {
      instance.addWarehouse(1000, 4, 'MEM', 'MEM', {from: web3.eth.accounts[2]});
      return instance;
    })
    .then((instance) => {
      instance.addWarehouse(10000, 4, 'SHA', 'SHA', {from: web3.eth.accounts[4]});
      return instance;
    })
    .then((instance) => {
      instance.addWarehouse(10000, 14, 'NSH', 'NSH', {from: web3.eth.accounts[5]});
      return instance;
    })

    // DEPLOY VEHICLES
    .then((instance) => {
      instance.addVehicle(1000, 8, 'STL', 'MEM',  Math.floor(moment().format('X')), Math.floor(moment().add(1,'days').format('X')), {from: web3.eth.accounts[3]});
      return instance;
    })
    .then((instance) => {
      instance.addVehicle(2500, 8, 'STL', 'CHI',  Math.floor(moment().format('X')), Math.floor(moment().add(2,'days').format('X')), {from: web3.eth.accounts[1]});
      return instance;
    })
    .then((instance) => {
      instance.addVehicle(1000, 8, 'MEM', 'NO',  Math.floor(moment().add(1,'days').format('X')), Math.floor(moment().add(3,'days').format('X')), {from: web3.eth.accounts[2]});
      return instance;
    })
    .then((instance) => {
      instance.addVehicle(10000, 8, 'MEM', 'SHA',  Math.floor(moment().add(1,'days').format('X')), Math.floor(moment().add(6,'days').format('X')), {from: web3.eth.accounts[4]});
      return instance;
    })
    .then((instance) => {
      instance.addVehicle(10000, 8, 'SHA', 'NY',  Math.floor(moment().add(6,'days').format('X')), Math.floor(moment().add(7,'days').format('X')), {from: web3.eth.accounts[5]});
      return;
    });
};
