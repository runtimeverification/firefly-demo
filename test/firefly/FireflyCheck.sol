pragma solidity ^0.5.16;

contract FireflyCheck {
    uint256 dummy;

    function firefly_assume(bool) external { dummy = 0; }
    function firefly_assert(bool) external { dummy = 0; }
}
