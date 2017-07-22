pragma solidity 0.4.11;

import 'tokens/StandardToken.sol';

contract Depot {    
    string public name = 'Depot';                   
    uint8 public decimals = 0;               
    string public symbol= 'Dpt';           
    string public version = 'H0.1';
    enum Types {Regular, Refridgerated}

    struct Warehouse {
        uint spaceAvailable,
        Types typeOfWarehouse,
    }


    function Depot() {
    }

    function warehouseAddSpace(uint cubicFeet, uint type) {
        balances[msg.sender] += cubicFeet;

    }
}