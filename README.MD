
## Install

```
npm install -g truffle
npm install -g ganache
npm install
```

# Run test

```
ganache --account 0x503d30470b57849f35972ba58d700153b214ae301121ba2dc389e04224bc2e87,0x1000000000000000000 --account 0xc09ae3abc13c501fb9ff1c3c8ad3256678416f73a41433411f1714ae7b547fe3,0x1000000000000000000 --account 0xecbcd49667c96bcf8b30ccb35234a0b217ea039a8e097d3a70de9d28624ba520,0x1000000000000000000 --account 0x1c98ac23c478461442a3d1489b9fd65779475b45c917ac1129db68d91b6654b8,0x1000000000000000000 --account 0x4f1c10dbf5a4c833e0f1e091ce06ba339c3194d249de8906a2b2ca642be07966,0x1000000000000000000 --account 0xe0ffe7cc4cd698cc18a012b473b6d09948d463ac6122462c0f1fca7aaa4b2467,0x1000000000000000000 --account 0xee8a7be04a25e07cb44497dfb3ec125e0098b5eab0580f1e5c3fb5bb8ef1589d,0x1000000000000000000 --account 0x8541b0d841a746e41f6093d16ab502c6179b727e775fb5feca77dd49e6b0ed8a,0x1000000000000000000 --account 0xc148e0908bdb5fdde1d06c7b61344e5719ab2e5cf2c24890db974bfd6af21830,0x1000000000000000000 --account 0xc4b730653072490a1f465ad5c4d7314005c61e30cb5f44784c203966492a3396,0x1000000000000000000 --account 0xfbc02def4107745fbc0de688535bb2b3239ad142614affc660845c3a2e0730f7,0x1000000000000000000 --account 0x31997ee61e6ad616ebde802e14b2a3c6b9a7d20d626a5aa326b9f4a741bab139,0x1000000000000000000 --account 0x88216efcd0fd7941538d564937dd35238b2610b7d0ab5cb3f3798eef7b010eb4,0x1000000000000000000 -i 999 -u 0 -u 1 -u 2 -u 3 -u 4 -u 5 -u 6 -u 7 -u 8 -u 9 -u 10 -l 200000000

truffle test
```

```
--account   Account data in the form <private_key>,<initial_balance>, can be specified multiple
times. Note that private keys are 64 characters long and must be entered as an
0x-prefixed hex string. Balance can either be input as an integer, or as a 0x-prefixed
hex string with either form specifying the initial balance in wei.

-l  Sets the block gas limit in WEI.

-i  The id of the network returned by the RPC method net_version.

-u  Array of addresses or address indexes specifying which accounts should be unlocked.
```

⚠️ It looks like different versions of `ganache` sign data in different ways (parameter `v`), so you may need to comment/uncomment [utils.js#L41](https://github.com/ton-blockchain/bridge-solidity/blob/master/test/utils/utils.js#L41).

## Deploy

> ⚠️ Don't deploy bridge smart contracts with same addresses and same oracle set in different EVM networks to prevent replay attack (`chainId` not included in signing data).

> ⚠️ Oracle's address [can't](https://github.com/ton-blockchain/bridge-solidity/blob/290f1be610f23ad3f700e06aebd92b71ccf6af70/contracts/SignatureChecker.sol#L43) be zero.

> ⚠️ NOTE: In practice, the number of oracles should be chosen to be divisible by 3.
> Note that in other cases minimum consensus is `floor( 2 * oracles_count / 3 )`. For example, with 4 oracles only 2 signatures required.

Change HDWalletProvider mnemonic and endpoint in `truffle-cofnig.js`.

You can get Ethereum Mainnet/Testent endpoints for example in https://infura.io.

You can get BSC Mainnet/Testnet endpoints in https://docs.bnbchain.org/docs/rpc/.

Ethereum Goerli Testnet:

```bash
truffle deploy --network goerli
```

BSC Testnet:

```bash
truffle deploy --network bsc_testnet
```

Ethereum Mainnet:

```bash
truffle deploy --network eth_mainnet
```

BSC Mainent:

```bash
truffle deploy --network bsc_mainnet
```

## ERC20

`ERC20.sol` and `IERC20.sol` from https://github.com/OpenZeppelin/openzeppelin-contracts/blob/24a0bc23cfe3fbc76f8f2510b78af1e948ae6651/contracts/token/ERC20/ (master branch, 22.02.2021, 19:44).

Differences:

1. `import "../../utils/Context.sol";` removed;
  all `_msgSender()` replaced by `msg.sender`;

2. `pragma solidity ^0.7.4;` instead of `pragma solidity ^0.8.0;`;

3. minor differences in comments;