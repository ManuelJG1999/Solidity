// SPDX-License-Identifier: GLP -3.0
pragma solidity 0.8.26;


         contract StorageCounter {
    string public storedInfo;
    uint public countChanges;

    constructor(string memory _storedInfo){ 
        storedInfo = _storedInfo;

        function getStoredInfo() public view returns (string memory){
        return storedInfo;
    }
    }
         }

    function setStoredInfo(string memory _storedInfo) public {
        storedInfo = _storedInfo;

         require(countChanges < 5, "The counter should be less than 5");

         countChanges++;
         storedInfo = _storedInfo;


    }
