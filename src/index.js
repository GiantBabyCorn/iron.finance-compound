const web3 = require('web3');
const truffle = require('truffle');
// console.log(`debug -> truffle`, truffle)

truffle.contracts.collectCompilations().then(console.log)
// web3.eth.call({
//     to: instanceLottery.address,
//     data: instanceLottery.contract.methods.getWeight('0b01010').encodeABI(),
// });
// web3.eth.sendTransaction({
//     to: instanceLottery.address,
//     data: instanceLottery.contract.methods.openGame().encodeABI(),
//     from: accounts[0],
// });

// instanceProxy.upgradeDelegate.sendTransaction(instanceLottery.address, {
//     from: accounts[0],
// });

// web3.eth.call({
//     to: instanceProxy.address,
//     data: instanceLottery.contract.methods.getWeight('0b01010').encodeABI(),
// });
// web3.eth.sendTransaction({
//     to: instanceProxy.address,
//     data: instanceLottery.contract.methods.openGame().encodeABI(),
//     from: accounts[0],
// });