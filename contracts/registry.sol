pragma solidity >=0.4.22 <0.6.0;

contract hotpotRegistry {
    address[] hotpots;
    uint numHotpots;
    constructor() public {}
    
    function register() public {
        hotpots.push(msg.sender);
        numHotpots += 1;
    }
    function viewRegistryAtI(uint i) public view returns (address) {
        return hotpots[i];
    }
    function getNumHotpots() public view returns (uint) {
        return numHotpots;
    }
}
