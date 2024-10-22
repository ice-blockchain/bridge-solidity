// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.7.0;

import {Bridge} from "./Bridge.sol";
import {IonUtils} from "./IonUtils.sol";
pragma experimental ABIEncoderV2;

contract BridgeDebugger is Bridge {
    constructor(string memory name_, string memory symbol_, address[] memory initialSet)
    Bridge(name_, symbol_, initialSet) {
        allowBurn = true;
    }

    /// @notice Allows minting of WrappedION tokens to any address for debugging purposes.
    /// @dev This function should only be used in a testing environment.
    /// @param receiver The address to receive the minted tokens.
    /// @param amount The amount of tokens to mint.
    function mintForDebugging(address receiver, uint256 amount) public {
        // Create a dummy SwapData struct with placeholder data
        SwapData memory sd;
        sd.receiver = receiver;
        sd.amount = uint64(amount);
        sd.tx.address_.workchain = 0;
        sd.tx.address_.address_hash = bytes32(0);
        sd.tx.tx_hash = bytes32(0);
        sd.tx.lt = 0;

        // Call the internal mint function from WrappedION
        mint(sd);
    }
}
