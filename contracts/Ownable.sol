// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

// This contract handles the owner logic
abstract contract Ownable {
    // mutisig address
    address public constant owner = 0xDFDe8108E14c70B6796bdd220454A80E849C7689;

    string public constant ERROR_NOT_OWNER = "Caller is not the owner";

    // The core access control modifier
    modifier onlyOwner() {
        require(msg.sender == owner, ERROR_NOT_OWNER);
        // The '_' executes the body of the function it is attached to
        _;
    }
}
