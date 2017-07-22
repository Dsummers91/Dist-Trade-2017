pragma solidity 0.4.11;

import 'tokens/StandardToken.sol';

contract Depot is StandardToken {    
    enum Types {Regular, Refridgerated}
    string public name = 'Depot';                   
    uint8 public decimals = 0;               
    string public symbol= 'Dpt';           
    string public version = 'H0.1';
    
    Warehouse[] public listOfWarehouses;

    struct Warehouse {
        uint spaceAvailable;
        uint pricePerCubicFootPerHour;
        Types typeOfWarehouse;
        address owner;
    }
    
    /** 
    * Constructs a new Depot 
    **/
    function Depot() {
    }

    function addWarehouse(uint256 _cubicFeet, uint pricePerCubicFootPerHour, bool isRefrigerated) not_warehouse {
        Types typeOfFridge = (isRefrigerated ? Types.Refridgerated : Types.Regular);
        totalSupply += _cubicFeet;
        listOfWarehouses.push(Warehouse(_cubicFeet, pricePerCubicFootPerHour, typeOfFridge, msg.sender));
    }

    function purchaseWarehouseSpace(address warehouseAddress, uint cubicFeet, uint amountOfHours) payable {
        Warehouse storage warehouse = getWarehouseByAddress(warehouseAddress);
        //Would probably import SafeMath module to multiply but MEH
        if(msg.value != (cubicFeet * amountOfHours * warehouse.pricePerCubicFootPerHour)) throw;  
        if(warehouse.spaceAvailable < cubicFeet) throw;
        warehouse.owner.transfer(msg.value);
        warehouse.spaceAvailable -= cubicFeet;
        totalSupply -= cubicFeet;
    }

    /** GETTER METHODS **/
    function warehouses() constant returns (uint[], uint[], uint[], address[]) {
        uint[] memory _spaceAvailable = new uint[](listOfWarehouses.length);
        uint[] memory _pricePerCubicFootPerHour = new uint[](listOfWarehouses.length);
        uint[] memory _typeOfWarehouse = new uint[](listOfWarehouses.length);
        address[] memory _owner = new address[](listOfWarehouses.length);

        for (var i = 0; i < listOfWarehouses.length; i++) {
            _spaceAvailable[i] = listOfWarehouses[i].spaceAvailable;
            _typeOfWarehouse[i] = uint(listOfWarehouses[i].typeOfWarehouse);
            _pricePerCubicFootPerHour[i] = listOfWarehouses[i].pricePerCubicFootPerHour;
            _owner[i] = listOfWarehouses[i].owner;
        }

        return (_spaceAvailable, _typeOfWarehouse, _pricePerCubicFootPerHour, _owner);
    }

    /** INTERNAL METHODS **/
    function getWarehouseByAddress(address addr) internal returns (Warehouse storage) {
        for (var i = 0; i < listOfWarehouses.length; i++) {
            if(listOfWarehouses[i].owner == addr) return listOfWarehouses[i];
        }
        throw;
    }

    /** Do not accept ether **/
    function () payable {
        throw;
    }

    /** MODIFIER METHODS ***/
    modifier not_warehouse {
        for (var i = 0; i < listOfWarehouses.length; i++) {
            if(listOfWarehouses[i].owner == msg.sender) throw;
        }
        _;
    }
}