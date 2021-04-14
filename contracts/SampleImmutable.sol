pragma solidity >=0.6.12;

contract SampleImmutable {
    uint256 public immutable imt;

    constructor(uint256 value) public {
        imt = value;
    }

    function getImmutable() external view returns (uint256 val) {
        val = imt;
    }
}
