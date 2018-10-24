pragma solidity ^0.4.24;


import "../../contracts/MultiownableWithTimeout.sol";

contract SimpleStorage is MultiownableWithTimeout
{
    constructor(uint _value) MultiownableWithTimeout() public
    {
        value = _value;
    }

    function set(uint newValue) public
    {
        value = newValue;
    }

    function get() public returns (uint value)
    {
        return value;
    }

    uint value;
}
