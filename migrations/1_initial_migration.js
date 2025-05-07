const Bridge = artifacts.require("Bridge");

module.exports = async function (deployer, network, accounts) {
  if (network === "development") {
    await deployer.deploy(Bridge, "Ice Open Network", "ION", [accounts[0]]);
  }

 if (network === "bsc_mainnet") {
   console.log('Deploy from ' + accounts[0]);
   await deployer.deploy(Bridge, "Ice Open Network", "ION",
                         ['0xd9fef78c18e3a0a6dda47008f2ba447d1c74af9a',
                          '0xa73c1686aa860747e6b06b1e5f86af63c9fa4646',
                          '0x6d1f779093c38307b156da4dd9e4f48994fe3c3f',
                          '0x559d1fb13a9f10fc58201673d0762b49ebc3916f',
                          '0xefe3f9342eeeaf03db4e11c74e8c8f5a0af87449',
                          '0xd73db63f5eeba62c950c5eaa39a676962d6013f3',
                          '0x67a706787f9e853322929467dc3640a154205e46',
                          '0xbe617a76ba3cb655e17d63fe24a31c2e3a87bdf8',
                          '0x969333638454fb4b4861f8ab3231bd08ffecca26',
                          '0x086e935329fd489a4268511d843f38ebcd7c6426'], {from:accounts[0]});
 }
};
