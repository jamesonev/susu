pragma solidity >=0.4.22 <0.6.0;

// import "@openzeppelin/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "./CEther.sol";
import "./registry.sol";
// import "github.com/compound-finance/compound-protocol/contracts/CEther.sol"; 


// Compound v2 on Rinkeby: 0xd6801a1dffcd0a410336ef88def4320d6df1883e
// on Mainnet? 0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2
contract hotpot {
    using SafeMath for uint;
    // CEther ceth = CEther(address(0xd6801a1DfFCd0a410336Ef88DeF4320D6DF1883e));
    // mapping (address => uint) public balances;
    address payable[] contributers;
    mapping (address => uint) payouts;
    uint payout;
    uint nextDrawBlock;
    uint minInvestment;
    uint maxInvestment;
    uint minUsers;
    uint maxUsers;
    uint numUsers;
    uint internalPools;
    bytes32 random;
    bool ended;
    event DrawingEnded();
    constructor(
        // uint _blocksToNextDrawing,
        // uint _minInvestment,
        // // if you uncomment this, add it to initialize below also
        // // uint _maxInvestment,
        // uint _minUsers,
        // uint _maxUsers,
        // uint _internalPools
    ) public {
        // initialize(_blocksToNextDrawing, _minInvestment, _minUsers, _maxUsers, _internalPools);
        ended = true;
        numUsers = 0;
        nextDrawBlock = 0;
    }
    function initialize(
        uint _blocksToNextDrawing,
        uint _minInvestment,
        // uint _maxInvestment,
        uint _minUsers,
        uint _maxUsers,
        uint _internalPools
    ) private {
        require(
            _blocksToNextDrawing <= 5000,    // some arbitrary threshhold to ensure our contract doesn't get locked up forever
            "blocksToNextDrawing must be <= 5000"
        );
        require(
            _maxUsers > 1,      //ensure we can have at least 2 people in the pool
            "at least 2 participants must be allowed to join"
        );
        require(
            _minUsers <= _maxUsers,
            "minUsers must be <= maxUsers"
        );
        require(
            _minInvestment > 0,
            "minInvestment cannot be zero"
        );
        // require
        //     _maxInvestment >= _minInvestment,
        //     "investment maximum must be greater that investment minimum"
        // );
        nextDrawBlock =  _blocksToNextDrawing.add(block.number);
        minInvestment = _minInvestment;
        // TODO: Implement variable contribution lotteries
        maxInvestment =  _minInvestment;
        minUsers =  _minUsers;
        maxUsers =  _maxUsers;
        internalPools = _internalPools;
        numUsers = 0;
        payout = 0;
        ended = false;
        random = blockhash(block.number - 1);
        hotpotRegistry registry = hotpotRegistry(address(0xD5c2a262d536c341641DefB39A5ec734bee84D65));
        registry.register();
    }
    function deposit() public payable {
        require(
            block.number <= nextDrawBlock,
            "Drawing already ended."
        );
        require(
            msg.value == minInvestment,
            "Deposit must be equal to minInvestment."
        );
        // require(
        //     balances[msg.sender].add(msg.value) >= minInvestment,
        //     "Deposit must be greater than or equal to minInvestment."
        // );
        // require(
        //     balances[msg.sender].add(msg.value) <= maxInvestment,
        //     "Deposit must be greater than or equal to maxInvestment."
        // );
        require(
            numUsers < maxUsers,
            "This pool is already full."
        );
        // ceth.mint();
        contributers.push(msg.sender);
        numUsers = numUsers.add(1);
        // balances[msg.sender] = balances[msg.sender].add(msg.value);
        payout = payout.add(msg.value);
    }
    function getRandom()  private returns (bytes32) {
        random = bytes32(keccak256(abi.encode(random)));
        // random = random xor keccak256(blockhash(block.number - 1));
        return random;
    }
    // function getRandomUser() view private returns (address) {
    //     return msg.sender;
    //     // return 
    // }
    function doDrawing() public {
        require(
            block.number >= nextDrawBlock,
            "Wait time has not passed"
        );
        require(
            !ended,
            "Payout have already been completed"
        );
        if(numUsers == 0){
            ended = true;
            emit DrawingEnded();
            return;
        }
        payout /= internalPools;
        ended = true;
        for (uint i=0; i<internalPools; i++) {
            payouts[contributers[uint256(getRandom()) % numUsers]] += payout;
        }
        emit DrawingEnded();
        payout = 0;
    }
    function withdraw() public {
        require(
            payouts[msg.sender] > 0,
            "Sorry, you didn't win any money"
        );
        uint amount = payouts[msg.sender];
        require(
            true,
            // ceth.redeem(amount) == 0,
            "withdrawal from Compound failed"
        );
        payouts[msg.sender] = 0;
        msg.sender.transfer(amount);
    }
    function restart(
        uint _blocksToNextDrawing,
        uint _minInvestment,
        uint _minUsers,
        uint _maxUsers,
        uint _internalPools
    ) public {
        require(
            ended,
            "The previous pool is still in use"
        );
        // This is not safe against a DoS attack; future versions should fix
        for (uint i = 0; i < numUsers; i++){
            require(
                payouts[contributers[i]] == 0,
                "Not all funds have been withdrawn from last round"
            );
        }
        initialize(_blocksToNextDrawing, _minInvestment, _minUsers, _maxUsers, _internalPools);
    }
    function getCurrentPayout() public view returns (uint) {
        return payout;
    }
    function getMinUserCount() public view returns (uint) {
        return minUsers;
    }
    function getMaxUserCount() public view returns (uint) {
        return maxUsers;
    }
    function getMinInvestment() public view returns (uint) {
        return minInvestment;
    }
    // function getMaxInvestment() public view returns (uint) {
    //     return maxInvestment;
    // }
    function getInternalPoolCount() public view returns (uint) {
        return internalPools;
    }
    function getBlocksRemaining() public view returns (uint) {
        return nextDrawBlock - block.number;
    }
    function getNumUsers() public view returns (uint) {
        return numUsers;
    }
}
