const getMetaMask = () => {
    if (window.ethereum === 'undefined') {
        var win = window.open('https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn', '_blank');
        win.focus();
    } else {
        if (ethereum.chainId !== "0x4") {
            this.alert("Please change to Rinkeby test net");
            return;
        }
        this.window.location.href = './onboarding1.html';
    }
}
