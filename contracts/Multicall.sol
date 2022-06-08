// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MultiCall {
    // @param targets, enter the address of the contract as many times as you have elements in data
    // @param data elements are the value return by abi.encodeWithSelector(this.funcName.selector)
    function multiCall(address[] calldata targets, bytes[] calldata data)
        external
        view
        returns (bytes[] memory)
    {
        require(targets.length == data.length, "target length != data length");

        bytes[] memory results = new bytes[](data.length);

        for (uint i; i < targets.length; i++) {
            (bool success, bytes memory result) = targets[i].staticcall(data[i]);
            require(success, "call failed");
            results[i] = result;
        }

        return results;
    }
}