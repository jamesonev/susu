## HotPot

HotPot is a blockchain-based implementation of a ['susu'](https://en.wikipedia.org/wiki/Susu_(informal_loan_club)). While susu's are normally based on the trust among participants (commonly friends or family members), our version is totally trustless. Susus are common in much of the developing world and in Asia.

### Implementation

We developed a smart-contract (`hotpot.sol`) that is currently depolyed on Rinkeby. Users can join the susu by interacting with the smart contract from a browser with metamask. The contract allows anyone to create a susu or join an existing susu. The creator of a susu using our contract can specify the buy-in amount, the minimum and maximum number of users (so they can bound the odds of each person winning). They also can can configure something called the `_internalPools` which act as lotteries within the lottery. More internal pools allow for more winners (each getting a proportional piece of the payout), and this reduces variance by increasing the median payout per player per round.

### Positive-Sum

One amazing aspect of running a susu on ethereum is that they money doesn't need to sit idly while it is waiting to get paid out; we can seamlessly interact with other DeFi infrastructure (in this case Compound) to earn interest on the pot until users request their funds from our contract. [Compound withdrawals are not production-ready].

### Lack of Trust

To make our susu trustless, we needed to change more about the normal structure than just to put it on the blockchain. Normally, susu participants rotate in order receiving the payout. However, on the blockchain, this would let a bad actor join the susu right before their slot is scheduled to receive a payout. To combat this, we needed to make the payout schedule unpredictable (similar to a lottery where a participant is chosen at random).
