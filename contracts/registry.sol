pragma solidity >=0.4.22 <0.6.0;

contract hotpotRegistry {
    address[] hotpots;
    constructor() public {}
    
    function register() public {
        hotpots.push(msg.sender);
    }
    func
}
