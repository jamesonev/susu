const Eth = require('ethjs');
const eth = new Eth(new Eth.HttpProvider('https://rinkeby.infura.io'));

const hotpot = eth.contract(tokenABI).at('0x6e0E0e02377Bc1d90E8a7c21f12BA385C2C35f78');

var fs = require('fs');
var obj = JSON.parse(fs.readFileSync('../../build/hotpot.json', 'utf8'));
const ABI = obj['abi'];n
console.log(ABI);
