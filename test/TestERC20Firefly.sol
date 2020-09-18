pragma solidity ^0.5.16;

import "./firefly/FireflyCheck.sol";
import "../contracts/ERC20.sol";

contract TestERC20Symbolic is FireflyCheck {
    function _testTransfer() public {
        ERC20 token;

        // token = (magic happens here)

        address from  = address(this);
        address to    = this.firefly_genAddress();
        uint256 value = this.firefly_genUint256();

        require(from != to);

        uint256 balFrom = token.balanceOf(from);
        uint256 balTo   = token.balanceOf(to);
        require(value <= balFrom);

        require(token.transfer(to, value));

        uint256 balFromAfter = token.balanceOf(from);
        uint256 balToAfter   = token.balanceOf(to);

        this.firefly_assert(balFromAfter <= balFrom);
        this.firefly_assert(balToAfter >= balTo);

        this.firefly_assert(balFrom - balFromAfter == balToAfter - balTo);
    }
}
