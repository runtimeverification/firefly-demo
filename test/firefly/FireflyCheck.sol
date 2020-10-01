pragma solidity >=0.5.16;

contract FireflyCheck {
    uint256 dummy;

    function firefly_genAddress() external returns (address) { dummy = 0; return address(1); }
    function firefly_genUint256() external returns (uint256) { dummy = 0; return 0; }

    function firefly_require(bool condition) external { dummy = 0; }
    function firefly_assert(bool condition) external { dummy = 0; }
}
