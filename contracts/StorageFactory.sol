// SPDX-License_Identifier: MIT

pragma solidity ^0.8.30;

// first. import freecodecamp.sol

import "./SimpleStorage.sol";

contract StorageFactory is SimpleStorage { //inheritence

    SimpleStorage[] public simpleStorageArray;
    function createSimpleStorageContract() public {
        //create an object of type SimpleStorage contract, name "simpleStorage"
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }
    
    //storagefactor store
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        //Address
        //ABI, Application Binary Interface
        SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        simpleStorage.store(_simpleStorageNumber);
    }
    //simpler code
    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256){
        return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieve();
    }
}