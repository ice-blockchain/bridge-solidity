// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

// This contract handles the owner logic
abstract contract Ownable {
    // Stored as 'private immutable' for gas efficiency
    address private immutable _owner;

    string public constant ERROR_NOT_OWNER = "Caller is not the owner";

    // Event to log the ownership transfer
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    // Set the contract deployer as the initial owner
    constructor() {
        _owner = msg.sender;
        emit OwnershipTransferred(address(0), msg.sender);
    }

    // The core access control modifier
    modifier onlyOwner() {
        require(msg.sender == _owner, ERROR_NOT_OWNER);
        // The '_' executes the body of the function it is attached to
        _;
    }

    // Function to allow getting the owner's address
    function owner() public view virtual returns (address) {
        return _owner;
    }
}
