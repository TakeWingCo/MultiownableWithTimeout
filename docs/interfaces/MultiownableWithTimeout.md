# MultiownableWithTimeout Documentation
`Solidity version 0.4.24`
## Summary

Contract provides interface with modifier for voting with timeout.
## Contract Details

`Contract parents:` 	 **Multiownable**;
### Events

#### OwnershipTransferred(address[] previousOwners, uint howManyOwnersDecide, address[] newOwners, uint newHowManyOwnersDecide);
#### OperationCreated(bytes32 operation, uint howMany, uint ownersCount, address proposer);
#### OperationUpvoted(bytes32 operation, uint votes, uint howMany, uint ownersCount, address upvoter);
#### OperationPerformed(bytes32 operation, uint howMany, uint ownersCount, address performer);
#### OperationDownvoted(bytes32 operation, uint votes, uint ownersCount,  address downvoter);
#### OperationCancelled(bytes32 operation, address lastCanceller);

### Modifiers

#### NotExpired(uint timePerOperation)
#### onlyAnyOwner()
#### onlyManyOwners()
#### onlyAllOwners()
#### onlySomeOwners(uint howMany)

### Constructor

#### constructor() Multiownable() public
`Description:`	Contract initialization

### Public functions

#### function isOwner(address wallet) public constant returns (bool)
#### function ownersCount() public constant returns (uint)
#### function allOperationsCount() public constant returns (uint)
#### function cancelPending(bytes32 operation) public onlyAnyOwner
#### function transferOwnership(address[] newOwners) public
#### function transferOwnershipWithHowMany(address[] newOwners, uint256 newHowManyOwnersDecide) public onlyManyOwners

### Public members

#### ownersGeneration
`Type:`	uint256
#### howManyOwnersDecide
`Type:`	uint256
#### owners
`Type:`	address[]
#### allOperations
`Type:`	bytes32[]
#### ownersIndices
`Type:`	mapping(address => uint)
#### allOperationsIndicies
`Type:`	mapping(bytes32 => uint)
#### votesMaskByOperation
`Type:`	mapping(bytes32 => uint256)
#### votesCountByOperation
`Type:`	mapping(bytes32 => uint256)
