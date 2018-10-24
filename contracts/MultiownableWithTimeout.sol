pragma solidity ^0.4.24;


import "/home/ganzz/takewing/MultiownableWithTimeout/contracts/Multiownable/contracts/Multiownable.sol";


// Multiownable contract with timeout for every function.
contract MultiownableWithTimeout is Multiownable
{
    // Check that time hasn't expired. Use it before only_N_owners modifier.
    modifier NotExpired(uint timePerOperation)
    {
        require(isOwner(msg.sender));
        bytes32 operation = keccak256(msg.data, ownersGeneration);

        if (votesCountByOperation[operation] == 0)
        {
            endOperationTime[operation] = block.timestamp + timePerOperation;
        }

        if (block.timestamp > endOperationTime[operation])
        {   
            super.deleteOperation(operation);
            delete endOperationTime[operation];
        }
        else
        {
            _;
        }
    }

    constructor() Multiownable() public
    {
    }

    mapping (bytes32 => uint) public endOperationTime;
}
