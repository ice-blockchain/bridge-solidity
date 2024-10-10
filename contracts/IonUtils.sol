// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

interface IonUtils {
    struct IonAddress {
        int8 workchain;
        bytes32 address_hash;
    }
    struct IonTxID {
        IonAddress address_; // sender user address in ION network
        bytes32 tx_hash; // transaction hash on ION bridge smart contract
        uint64 lt; // transaction LT (logical time) on ION bridge smart contract
    }

  struct SwapData {
        address receiver; // user's EVM-address to receive wrapped IONs
        uint64 amount; // nanoions amount to receive in EVM-network
        IonTxID tx;
  }
  struct Signature {
        address signer; // oracle's EVM-address
        bytes signature; // oracle's signature
  }

}
