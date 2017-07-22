var Depot = artifacts.require("./Depot.sol");

let depot;
contract('Depot', function(accounts) {
  it("should allow buyer to purchase space", function() {
    Depot.deployed()
      .then((instance) => {
        depot = instance;
        instance.purchaseWarehouseSpace(web3.eth.coinbase, 50, 1, {value: 50, from: web3.eth.coinbase})
      })
      .then(() => {
        return depot.warehouses()
      })
      .then((warehouses) => {
        console.log(warehouses);
      })
  });
});
