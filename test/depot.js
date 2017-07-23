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
        return;
        // return depot.warehousesByCity('STL');
      })
      .then((warehouses) => {
        console.log(warehouses);
        console.log(getWarehouses(warehouses));
        return;
      })
  });
});


function getWarehouses(warehouses) {
  let readableWarehouse = [];
  let properties = [
    {name:'spaceAvailable', type: 'number'}, 
    {name: 'totalSpace', type:'number'}, 
    {name: 'pricePerCubicFootPerHour', type: 'number'}, 
    {name: 'owner', type:'address'}, 
    {name: 'beginningCity', type: 'string'}, 
    {name: 'endingCity', type:'string'}];

      console.log('fdfs');
    for (var j = 0; j < properties.length; j++) {
  for (var i = 0; i < warehouses[0].length; i++) {
    readableWarehouse[i] = {};
      if(properties[j].type === 'string') warehouses[j][i] = web3.toUtf8(warehouses[j][i]);
      
    }
    
  }
}