const getMetaMask = () => {
    if (window.ethereum === 'undefined') {
        var win = window.open('https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn', '_blank');
        win.focus();
    } else {
        this.window.location.href = './onboarding1.html';
    }
}
