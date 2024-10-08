const ION_WORKCHAIN = -1;
const ION_ADDRESS_HASH = '0x2175818712088C0A5F087DF2594A41CB5CB29689EB60FC59F6848D752AF11498';
const ION_TX_HASH = '0x6C79A5432D988FFAD699E60C4A6E9C7E191CBE5A1BD199294C1F3361D0893359';
const ION_TX_LT = 19459352000003;

let prepareSwapData = function(receiver, amount,
                               tonaddress={workchain:ION_WORKCHAIN, address_hash:ION_ADDRESS_HASH},
                               tx_hash=ION_TX_HASH, lt=ION_TX_LT) {
    if (lt == ION_TX_LT) {
      lt = lt + Math.ceil(Date.now() / 1000)+Math.ceil(10000*Math.random());
    }
    return {
        receiver:receiver,
        amount:amount,
        tx: {
            address_: tonaddress,
            tx_hash: tx_hash,
            lt: lt
        }
    }
};
let encodeSwapData = function(d, target) {
    console.log([0xDA7A, target, d.receiver, d.amount, d.tx.address_.workchain, d.tx.address_.address_hash, d.tx.tx_hash, d.tx.lt]);
    return web3.eth.abi.encodeParameters(['int', 'address', 'address', 'uint256', 'int8', 'bytes32', 'bytes32', 'uint64'],
        [0xDA7A, target, d.receiver, d.amount, d.tx.address_.workchain, d.tx.address_.address_hash, d.tx.tx_hash, d.tx.lt]);
}
let encodeSet = function(setHash, set, target) {
    return web3.eth.abi.encodeParameters(['int', 'address', 'int', 'address[]'], [0x5E7, target, setHash, set]);
}

let encodeBurnStatus = function(burnStatus, nonce, target) {
    return web3.eth.abi.encodeParameters(['int', 'address', 'bool', 'int'], [0xB012, target, burnStatus, nonce]);
}

let hashData = function(encoded) {
    return web3.utils.sha3(encoded)
}
let signHash = async function(hash, account) {
    let signature =  await web3.eth.sign(hash, account);
    signature = signature.slice(0, 2+2*64)+(parseInt(signature.slice(130),16)).toString(16);
    return {
        signer: account,
        signature: signature
    }
};
let signData = async function(swapData, account, target) {
    return await signHash(hashData(encodeSwapData(swapData, target)), account);
};
let signSet = async function(setHash, newSet, account, target) {
    return await signHash(hashData(encodeSet(setHash, newSet, target)), account);
};
let signBurnStatus = async function(burnStatus, nonce, account, target) {
    return await signHash(hashData(encodeBurnStatus(burnStatus, nonce, target)), account);
};

module.exports = Object({
    ION_WORKCHAIN:ION_WORKCHAIN,
    ION_ADDRESS_HASH:ION_ADDRESS_HASH,
    ION_TX_HASH:ION_TX_HASH,
    ION_TX_LT:ION_TX_LT,
    prepareSwapData:prepareSwapData,
    encodeSwapData:encodeSwapData,
    encodeSet:encodeSet,
    encodeBurnStatus:encodeBurnStatus,
    hashData:hashData,
    signHash:signHash,
    signData:signData,
    signSet:signSet,
    signBurnStatus:signBurnStatus
});
