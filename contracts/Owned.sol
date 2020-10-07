pragma solidity >=0.6.0;

contract Owned {
    constructor() public {
        owner = msg.sender;
    }

    address owner;

    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }
}
