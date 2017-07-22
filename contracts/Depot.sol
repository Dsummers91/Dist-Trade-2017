pragma solidity 0.4.11;

import 'tokens/StandardToken.sol';

contract Depot {    
    enum Types {Regular, Refridgerated}
    string public name = 'Depot';                   
    uint8 public decimals = 0;               
    string public symbol= 'Dpt';           
    string public version = 'H0.1';
    
    Warehouse[] listOfWarehouses;

    struct Warehouse {
        uint spaceAvailable;
        Types typeOfWarehouse;
        address owner;
    }


    function Depot() {
    }

    function addWarehouse(uint256 _cubicFeet, bool isRefrigerated) not_warehouse {
        Types typeOfFridge = (isRefrigerated ? Types.Refridgerated : Types.Regular);
        listOfWarehouses.push(Warehouse(_cubicFeet, typeOfFridge, msg.sender));
    }

    modifier not_warehouse {
        for (var i = 0; i < listOfWarehouses.length; i++) {
            if(listOfWarehouses[i].owner == msg.sender) throw;
        }
        _;
    }
}