pragma solidity ^0.4.24;


import "../../contracts/MultiownableWithTimeout.sol";

contract SimpleStorage is MultiownableWithTimeout
{
    constructor(uint _timeout, uint _value) Multiownable() public
    {
        timeout = _timeout;
        value = _value;
    }

    function set(uint newValue) onlyAnyOwner() public
    {
        value = newValue;
    }

    function setByVoters(uint newValue) onlyAllOwners() public
    {
        value = newValue;
    }

    function setByVotersWithTimeout(uint newValue) NotExpired(timeout) onlyAllOwners() public
    {
        value = newValue;
    }

    function get() public view returns (uint)
    {
        return value;
    }

    uint public value;

    uint public timeout;
}
