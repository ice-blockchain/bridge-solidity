// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

import "./ERC20.sol";
import "./IonUtils.sol";

abstract contract WrappedION is ERC20, IonUtils {
    bool public allowBurn;

    address public constant multisig = 0xDFDe8108E14c70B6796bdd220454A80E849C7689;
    string public constant ERROR_NOT_ALLOWED = "Caller isn't the expected multisig address";

    function mint(SwapData memory sd) internal {
      _mint(sd.receiver, sd.amount);
      emit SwapIonToEth(sd.tx.address_.workchain, sd.tx.address_.address_hash, sd.tx.tx_hash, sd.tx.lt, sd.receiver, sd.amount);
    }

    /**
     * @dev Destroys `amount` tokens from the caller and request transfer to `addr` on ION network
     *
     * See {ERC20-_burn}.
     */
    function burn(uint256 amount, IonAddress memory addr) external {
      require(allowBurn, "Burn is currently disabled");
      _burn(msg.sender, amount);
      emit SwapEthToIon(msg.sender, addr.workchain, addr.address_hash, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, deducting from the caller's
     * allowance and request transfer to `addr`
     *
     * See {ERC20-_burn} and {ERC20-allowance}.
     *
     * Requirements:
     *
     * - the caller must have allowance for ``accounts``'s tokens of at least
     * `amount`.
     */
    function burnFrom(address account, uint256 amount, IonAddress memory addr) external {
        require(allowBurn, "Burn is currently disabled");
        uint256 currentAllowance = allowance(account,msg.sender);
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
        _approve(account, msg.sender, currentAllowance - amount);
        _burn(account, amount);
        emit SwapEthToIon(account, addr.workchain, addr.address_hash, amount);
    }

    function decimals() public pure override returns (uint8) {
        return 9;
    }

    function changeName(string memory newName) public {
        require(msg.sender == multisig, ERROR_NOT_ALLOWED);
        _name = newName;
        emit NameChanged(newName, msg.sender);
    }

    function changeSymbol(string memory newSymbol) public {
        require(msg.sender == multisig, ERROR_NOT_ALLOWED);
        _symbol = newSymbol;
        emit SymbolChanged(newSymbol, msg.sender);
    }

    event SwapEthToIon(
        address indexed from, // sender user EVM-network
        int8 to_wc, // workchain of receiver user in ION-network
        bytes32 indexed to_addr_hash, // // address of receiver user in ION-network
        uint256 value // amount in nanoions
    );
    event SwapIonToEth(
        int8 workchain, // sender user workchain in ION network
        bytes32 indexed ion_address_hash, // sender user address in ION network
        bytes32 indexed ion_tx_hash, // transaction hash on ION bridge smart contract
        uint64 lt, // transaction LT (logical time) on ION bridge smart contract
        address indexed to, // user's EVM-address to receive wrapped IONs
        uint256 value // nanoions amount to receive in EVM-network
    );

    event NameChanged(
        string indexed newName,
        address indexed owner
    );

    event SymbolChanged(
        string indexed newSymbol,
        address indexed owner
    );
}
