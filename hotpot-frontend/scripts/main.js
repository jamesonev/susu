
// const Eth = require('ethjs');
// const eth = new Eth(new Eth.HttpProvider('https://rinkeby.infura.io'));

// const hotpot = eth.contract(tokenABI).at('0x6e0E0e02377Bc1d90E8a7c21f12BA385C2C35f78');

// var fs = require('fs');
// var obj = JSON.parse(fs.readFileSync('../../build/hotpot.json', 'utf8'));
// const ABI = obj['abi'];n
// console.log(ABI); 

const getAccounts = async () => {
    const accounts = await ethereum.enable();
    return accounts.value;

}
window.addEventListener('load', function () {
    // Check if Web3 has been injected by the browser:
    if (typeof window.ethereum !== 'undefined') {
        ethereum.enable();
        account = ethereum.selectedAddress;
        // if (this.window.location == "http://localhost:8000/hotpot-frontend/login.html") {
        //     this.window.location.href = './onboarding1.html';
        // }
        registryAbi = [
            {
                "inputs": [],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "constructor"
            },
            {
                "constant": false,
                "inputs": [],
                "name": "register",
                "outputs": [],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "function"
            }
        ]
        if (ethereum.chainId !== "0x4") {
            this.alert("Please change to Rinkeby test net");

        }


    } else {
        this.console.log("Web3 is not active");
        // Warn the user that they need to get a web3 browser
        // Or install MetaMask, maybe with a nice graphic.
    }

})
