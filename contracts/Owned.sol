pragma solidity >=0.5.16;

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
