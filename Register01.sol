// SPDX-License-Identifier: GLP -3.0
pragma solidity 0.8.22;

// Manuel Jimenez G.

contract Register01 {
    string private storedInfo;

    function setInfo(string memory myInfomjg) external {
        storedInfo = myInfomjg;
    }

    function getInfo() external view returns (string memory) {
        return storedInfo;
    }
}
