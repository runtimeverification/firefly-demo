pragma solidity ^0.5.16;

import "./firefly/FireflyCheck.sol";

contract TestFireflyCheckUnits is FireflyCheck {
    function _testAssume() public {
        this.firefly_assume(true);
    }

    function _testAssert() public {
        this.firefly_assert(true);
    }
}
