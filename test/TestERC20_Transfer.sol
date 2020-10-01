pragma solidity >=0.5.16;

import "./firefly/FireflyCheck.sol";
import "../contracts/ERC20.sol";

contract TestERC20Firefly_Transfer is FireflyCheck {
    function _testTransfer() public {
        address owner = this.firefly_genAddress();
        uint256 initSupply = this.firefly_genUint256();

        ERC20 token = new ERC20("gold", "GLD", owner, initSupply);

        address from  = address(this);
        address to    = this.firefly_genAddress();
        uint256 value = this.firefly_genUint256();

        this.firefly_require(from != to);

        uint256 balFrom = token.balanceOf(from);
        uint256 balTo   = token.balanceOf(to);
        this.firefly_require(value <= balFrom);

        this.firefly_require(token.transfer(to, value));

        uint256 balFromAfter = token.balanceOf(from);
        uint256 balToAfter   = token.balanceOf(to);

        this.firefly_assert(balFromAfter <= balFrom); //
        this.firefly_assert(balToAfter >= balTo);     // No overflows

        this.firefly_assert(balFrom    - balFromAfter == value);
        this.firefly_assert(balToAfter - balTo        == value);
    }

    function _testTransferSelf() public {
        address owner = this.firefly_genAddress();
        uint256 initSupply = this.firefly_genUint256();

        ERC20 token = new ERC20("gold", "GLD", owner, initSupply);

        address from  = address(this);
        address to    = address(this);
        uint256 value = this.firefly_genUint256();

        uint256 bal = token.balanceOf(from);
        this.firefly_require(value <= bal);

        this.firefly_require(token.transfer(to, value));

        uint256 balAfter = token.balanceOf(from);

        this.firefly_assert(balAfter == bal);
    }

    function _testTransferFail() public {
        address owner = this.firefly_genAddress();
        uint256 initSupply = this.firefly_genUint256();

        ERC20 token = new ERC20("gold", "GLD", owner, initSupply);

        address from  = address(this);
        address to    = this.firefly_genAddress();
        uint256 value = this.firefly_genUint256();

        this.firefly_require(from != to);

        uint256 balFrom = token.balanceOf(from);
        this.firefly_require(value > balFrom);

        this.firefly_assert(!token.transfer(to, value));
    }
}
