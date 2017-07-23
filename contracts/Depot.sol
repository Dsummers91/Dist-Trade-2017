pragma solidity 0.4.11;

import 'tokens/StandardToken.sol';

contract Depot is StandardToken {
    string public name = 'Depot';                   
    uint8 public decimals = 0;               
    string public symbol= 'Dpt';           
    string public version = 'H0.1';
    
    Warehouse[] public listOfWarehouses;
    Warehouse[] public listOfVehicles;

    struct Warehouse {
        uint spaceAvailable;
        uint totalSpace;
        uint pricePerCubicFootPerHour;
        address owner;
        bytes32 beginningCity;
        bytes32 endingCity;
        uint beginDate;
        uint endDate;
    }
    
    /** 
    * Constructs a new Depot 
    **/
    function Depot() {
    }

    function addWarehouse(uint256 _cubicFeet, uint pricePerCubicFootPerHour, bytes32 startingPosition, bytes32 endingPosition) {
        totalSupply += _cubicFeet;
        listOfWarehouses.push(Warehouse(_cubicFeet, _cubicFeet, pricePerCubicFootPerHour, msg.sender, startingPosition, endingPosition, 0, 0));
    }

    function addVehicle(uint256 _cubicFeet, uint pricePerCubicFootPerHour, bytes32 startingPosition, bytes32 endingPosition, uint beginDate, uint endDate) {
        totalSupply += _cubicFeet;
        listOfVehicles.push(Warehouse(_cubicFeet, _cubicFeet, pricePerCubicFootPerHour, msg.sender, startingPosition, endingPosition, beginDate, endDate));
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

    function purchaseVehicleSpace(address addr, uint cubicFeet, uint amountOfHours) payable {
        Warehouse storage warehouse = getVehicleByAddress(addr);
        //Would probably import SafeMath module to multiply but MEH
        uint price = cubicFeet * amountOfHours * warehouse.pricePerCubicFootPerHour;
        if(msg.value != price) throw;  
        if(warehouse.spaceAvailable < cubicFeet) throw;
        warehouse.spaceAvailable -= cubicFeet;
        totalSupply -= cubicFeet;
    }


    // /** GETTER METHODS **/
    function warehouses() constant returns (uint[], uint[], uint[], address[], bytes32[], bytes32[]) {
        uint[] memory _spaceAvailable = new uint[](listOfWarehouses.length);
        uint[] memory _totalSpace = new uint[](listOfWarehouses.length);
        uint[] memory _pricePerCubicFootPerHour = new uint[](listOfWarehouses.length);
        bytes32[] memory _beginningCity = new bytes32[](listOfWarehouses.length);
        bytes32[] memory _endingCity = new bytes32[](listOfWarehouses.length);
        address[] memory _owner = new address[](listOfWarehouses.length);

        for (var i = 0; i < listOfWarehouses.length; i++) {
            _spaceAvailable[i] = listOfWarehouses[i].spaceAvailable;
            _totalSpace[i] = listOfWarehouses[i].totalSpace;
            _pricePerCubicFootPerHour[i] = listOfWarehouses[i].pricePerCubicFootPerHour;
            _owner[i] = listOfWarehouses[i].owner;
            _beginningCity[i] = listOfWarehouses[i].beginningCity;
            _endingCity[i] = listOfWarehouses[i].endingCity;
        }
        return (_spaceAvailable, _totalSpace, _pricePerCubicFootPerHour, _owner, _beginningCity, _endingCity);
    }

    function vehicleDates() constant returns (uint[], uint[]) {
        uint[] memory _beginDate = new uint[](listOfVehicles.length);
        uint[] memory _endDate = new uint[](listOfVehicles.length);

        for (var i = 0; i < listOfVehicles.length; i++) {
          _beginDate[i] = listOfVehicles[i].beginDate;
          _endDate[i] = listOfVehicles[i].endDate;
        }
        return (_beginDate, _endDate);
    }

    function vehicles() constant returns (uint[], uint[], uint[], address[], bytes32[], bytes32[]) {
        uint[] memory _spaceAvailable = new uint[](listOfVehicles.length);
        uint[] memory _totalSpace = new uint[](listOfVehicles.length);
        uint[] memory _pricePerCubicFootPerHour = new uint[](listOfVehicles.length);
        bytes32[] memory _beginningCity = new bytes32[](listOfVehicles.length);
        bytes32[] memory _endingCity = new bytes32[](listOfVehicles.length);
        address[] memory _owner = new address[](listOfVehicles.length);

        for (var i = 0; i < listOfVehicles.length; i++) {
            _spaceAvailable[i] = listOfVehicles[i].spaceAvailable;
            _totalSpace[i] = listOfVehicles[i].totalSpace;
            _pricePerCubicFootPerHour[i] = listOfVehicles[i].pricePerCubicFootPerHour;
            _owner[i] = listOfVehicles[i].owner;
            _beginningCity[i] = listOfVehicles[i].beginningCity;
            _endingCity[i] = listOfVehicles[i].endingCity;
        }
        return (_spaceAvailable, _totalSpace, _pricePerCubicFootPerHour, _owner, _beginningCity, _endingCity);
    }

    function vehiclesByCity(bytes32 city) constant returns (uint[], uint[], uint[], address[], bytes32[], bytes32[]) {
        uint count;
        for (var j = 0; j < listOfWarehouses.length; j++) {
            if(listOfVehicles[j].beginningCity == city) count++;
        }

        uint[] memory _spaceAvailable = new uint[](count);
        uint[] memory _totalSpace = new uint[](count);
        uint[] memory _pricePerCubicFootPerHour = new uint[](count);
        bytes32[] memory _beginningCity = new bytes32[](count);
        bytes32[] memory _endingCity = new bytes32[](count);
        address[] memory _owner = new address[](count);

        for (var i = 0; i < listOfVehicles.length; i++) {
            if(listOfVehicles[i].beginningCity == city) {      
                _spaceAvailable[i] = listOfVehicles[i].spaceAvailable;
                _totalSpace[i] = listOfVehicles[i].totalSpace;
                _pricePerCubicFootPerHour[i] = listOfVehicles[i].pricePerCubicFootPerHour;
                _owner[i] = listOfVehicles[i].owner;
                _beginningCity[i] = listOfVehicles[i].beginningCity;
                _endingCity[i] = listOfVehicles[i].endingCity;
            }
        }
        return ( _spaceAvailable, _totalSpace, _pricePerCubicFootPerHour, _owner, _beginningCity, _endingCity);
    }


    // /** INTERNAL METHODS **/
    function getVehicleByAddress(address addr) internal returns (Warehouse storage) {
        for (var i = 0; i < listOfVehicles.length; i++) {
            if(listOfVehicles[i].owner == addr) return listOfVehicles[i];
        }
        throw;
    }

    function getWarehouseByAddress(address addr) internal returns (Warehouse storage) {
        for (var i = 0; i < listOfWarehouses.length; i++) {
            if(listOfWarehouses[i].owner == addr) return listOfWarehouses[i];
        }
        throw;
    }

    // /** Do not accept ether **/
    function () payable {
        throw;
    }
}