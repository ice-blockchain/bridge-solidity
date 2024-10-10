// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

import "./IonUtils.sol";


interface BridgeInterface is IonUtils {
  function voteForMinting(SwapData memory data, Signature[] memory signatures) external;
  function voteForNewOracleSet(int oracleSetHash, address[] memory newOracles, Signature[] memory signatures) external;
  function voteForSwitchBurn(bool newBurnStatus, int nonce, Signature[] memory signatures) external;
  event NewOracleSet(int oracleSetHash, address[] newOracles);
}
