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
        uint ID;
        uint spaceAvailable;
        uint totalSpace;
        uint pricePerCubicFootPerHour;
        address owner;
        bytes32 beginningCity;
        bytes32 endingCity;
    }
    
    /** 
    * Constructs a new Depot 
    **/
    function Depot() {
    }

    function addWarehouse(uint256 _cubicFeet, uint pricePerCubicFootPerHour, bytes32 startingPosition, bytes32 endingPosition) {
        totalSupply += _cubicFeet;
        listOfWarehouses.push(Warehouse(listOfWarehouses.length, _cubicFeet, _cubicFeet, pricePerCubicFootPerHour, msg.sender, startingPosition, endingPosition));
    }

    function purchaseWarehouseSpace(address addr, uint cubicFeet, uint amountOfHours) payable {
        Warehouse storage warehouse = getWarehouseByAddress(addr);
        //Would probably import SafeMath module to multiply but MEH
        uint price = cubicFeet * amountOfHours * warehouse.pricePerCubicFootPerHour;
        if(msg.value != price) throw;  
        if(warehouse.spaceAvailable < cubicFeet) throw;
        warehouse.spaceAvailable -= cubicFeet;
        totalSupply -= cubicFeet;
    }

    /** 
    * Dunno how we want to complete
    **/
    function completeAgreement(uint ID) {

    }

    /** GETTER METHODS **/
    function warehouses() constant returns (uint[], uint[], uint[], uint[], address[], bytes32[], bytes32[]) {
        uint[] memory _ID = new uint[](listOfWarehouses.length);
        uint[] memory _spaceAvailable = new uint[](listOfWarehouses.length);
        uint[] memory _totalSpace = new uint[](listOfWarehouses.length);
        uint[] memory _pricePerCubicFootPerHour = new uint[](listOfWarehouses.length);
        bytes32[] memory _beginningCity = new bytes32[](listOfWarehouses.length);
        bytes32[] memory _endingCity = new bytes32[](listOfWarehouses.length);
        address[] memory _owner = new address[](listOfWarehouses.length);

        for (var i = 0; i < listOfWarehouses.length; i++) {
            _ID[i] = listOfWarehouses[i].ID;
            _spaceAvailable[i] = listOfWarehouses[i].spaceAvailable;
            _totalSpace[i] = listOfWarehouses[i].totalSpace;
            _pricePerCubicFootPerHour[i] = listOfWarehouses[i].pricePerCubicFootPerHour;
            _owner[i] = listOfWarehouses[i].owner;
            _beginningCity[i] = listOfWarehouses[i].beginningCity;
            _endingCity[i] = listOfWarehouses[i].endingCity;
        }

        return (_ID, _spaceAvailable, _totalSpace, _pricePerCubicFootPerHour, _owner, _beginningCity, _endingCity);
    }

    /** INTERNAL METHODS **/
    function getWarehouseByAddress(address addr) internal returns (Warehouse storage) {
        for (var i = 0; i < listOfWarehouses.length; i++) {
            if(listOfWarehouses[i].owner == addr) return listOfWarehouses[i];
        }
        throw;
    }

    function getWarehouseByID(uint _ID) internal returns (Warehouse storage) {
        for (var i = 0; i < listOfWarehouses.length; i++) {
            if(listOfWarehouses[i].ID == _ID) return listOfWarehouses[i];
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