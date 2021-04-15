pragma solidity >=0.6.12;

contract SampleImmutable {
    uint256 public immutable imt;
    mapping (uint256 => uint256) store;

    constructor(uint256 value) public {
        imt = value;
    }

    function getImmutable() external view returns (uint256 val) {
        val = imt;
    }

    function sumToImmutable() external view returns (uint256 val) {
        val = 0;
        uint256 i = 0;
        while(i <= imt) {
            val += i;
            require(val >= i);
            i += 1;
        }
    }

    function storeAtImmutable(uint256 value) public{
        store[imt] = value;
    }

    function readAtImmutable() external view returns (uint256 val) {
        return store[imt];
    }
}
