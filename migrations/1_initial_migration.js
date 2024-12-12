const Bridge = artifacts.require("Bridge");

module.exports = async function (deployer, network, accounts) {
  if (network === "development") {
    await deployer.deploy(Bridge, "Ice Open Network", "ICE", [accounts[0]]);
  }

 if (network === "goerli" || network === "bsc_testnet") {
   console.log('Deploy from ' + accounts[0]);
   await deployer.deploy(Bridge, "Ice Open Network", "ICE",
                         ['0xbE4Eb1b396062D062b90b4caeE19ECb1a59265D1',
                          '0xa1C4B3cb4d524Cca4420A606daeDc6D15E488f10',
                          '0xb44C86F01c9158bC2f5b302bA6094517D0D94b83',
                          '0x574b3A9462a08a1A44d4861449B01205Cb029dc5',
                          '0x818F9585F31906647f7119fe9ee780D1614c266F',
                          '0xe588E92377ed8f8b290af13885a26941B1218e00',
                          '0x7a847519785F20Aac01865aFD73CDf83FbEDC104',
                          '0x778b8F44574c9B3ab915341D622F4224774FD666',
                          '0xE2DbB8d26F7B299ee2D920F3d4177C6aee2de6f1',
                          '0xba9EC76b26f6F90471F122773c356F73699cAa40'], {from:accounts[0]});
 }
};
