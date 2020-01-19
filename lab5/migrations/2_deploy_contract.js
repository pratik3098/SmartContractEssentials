const GBCCrowdSale = artifacts.require("GBCCrowdSale")
const StandardToken= artifacts.require("StandardToken")

module.exports = function(deployer) {
deployer.deploy(StandardToken)
deployer.deploy(GBCCrowdSale,"15","0xa1552303a356e7f00ddf0ab4e2495b1809f0d036","0x9090fbB28D27a85afFc1258A2A3972FD20fd3788")

};
