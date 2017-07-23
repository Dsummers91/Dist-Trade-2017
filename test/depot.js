var Depot = artifacts.require("./Depot.sol");

let depot;
contract('Depot', function (accounts) {
  it("should allow buyer to purchase space", function () {
    Depot.deployed()
      .then((instance) => {
        depot = instance;
        instance.purchaseWarehouseSpace(accounts[2], 50, 1, { value: 50, from: web3.eth.coinbase })
      })
      .then(() => {
        return depot.warehouses()
      })
      .then((warehouses) => {
        // console.log(warehouses);
        return depot.vehiclesByCity('STL');
      })
      .then((warehouses) => {
        console.log(getWarehouses(warehouses));
      })
  });
});

function getWarehouses(warehouses) {
  let readableWarehouse = [];
  let properties = [
    { name: 'spaceAvailable', type: 'number' },
    { name: 'totalSpace', type: 'number' },
    { name: 'pricePerCubicFootPerDuration', type: 'number' },
    { name: 'owner', type: 'address' },
    { name: 'beginningCity', type: 'string' },
    { name: 'endingCity', type: 'string' }
  ];

  for (var j = 0; j < properties.length; j++) {
    for (var i = 0; i < warehouses[0].length; i++) {
      readableWarehouse[i] = readableWarehouse[i] || {};
      if (properties[j].type === 'string') warehouses[j][i] = web3.toUtf8(warehouses[j][i]);
      if (properties[j].type === 'number') warehouses[j][i] = warehouses[j][i].toString();
      readableWarehouse[i][properties[j].name] = warehouses[j][i];
    }
  }
  return readableWarehouse;
}