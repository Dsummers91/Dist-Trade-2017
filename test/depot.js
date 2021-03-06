var Depot = artifacts.require("./Depot.sol");
var moment = require('moment');

let depot;
let v;
let d;
contract('Depot', function (accounts) {
  it("should allow buyer to purchase space", function () {
    Depot.deployed()
      .then((instance) => {
        depot = instance;
        instance.purchaseWarehouseSpace(accounts[2], 50, 1, { value: 200, from: web3.eth.coinbase })
      })
      .then(() => {
        return depot.warehouses()
      })
      .then((warehouses) => {
        // console.log(warehouses);
        return depot.vehiclesByCity('STL');
      })
      .then((warehouses) => {
        console.log(warehouses);
        v = warehouses;
        return depot.vehicleDatesByCity('STL');
      }).then((d) => {
        console.log(d);
        console.log(humanize(v, d));
        return;
      })
  });
});

function humanize(warehouses, dates) {
  let readableWarehouse = [];
  let properties = [
    { name: 'spaceAvailable', type: 'number' },
    { name: 'totalSpace', type: 'number' },
    { name: 'pricePerCubicFootPerDuration', type: 'number' },
    { name: 'owner', type: 'address' },
    { name: 'beginningCity', type: 'string' },
    { name: 'endingCity', type: 'string' }
  ];

  let dateProperties = [
    { name: 'beginDate', type: 'date' },
    { name: 'endDate', type: 'date' }
  ];

  for (var j = 0; j < properties.length; j++) {
    for (var i = 0; i < warehouses[0].length; i++) {
      readableWarehouse[i] = readableWarehouse[i] || {};
      if (properties[j].type === 'string') warehouses[j][i] = web3.toUtf8(warehouses[j][i]);
      if (properties[j].type === 'number') warehouses[j][i] = warehouses[j][i].toString();
      readableWarehouse[i][properties[j].name] = warehouses[j][i];
    }
  }
  if (dates) {
    for (var j = 0; j < dateProperties.length; j++) {
      for (var i = 0; i < warehouses[0].length; i++) {
        warehouses[j][i] = moment(dates[j][i].toString() * 1000).format('MM/DD/YYYY');
        readableWarehouse[i][dateProperties[j].name] = warehouses[j][i];
      }
    }
  }
  return readableWarehouse;
}