pragma solidity ^0.5.16;

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

        require(from != to);

        uint256 balFrom = token.balanceOf(from);
        uint256 balTo   = token.balanceOf(to);
        require(value <= balFrom);

        require(token.transfer(to, value));

        uint256 balFromAfter = token.balanceOf(from);
        uint256 balToAfter   = token.balanceOf(to);

        assert(balFromAfter <= balFrom); //
        assert(balToAfter >= balTo);     // No overflows

        assert(balFrom    - balFromAfter == value);
        assert(balToAfter - balTo        == value);
    }

    function _testTransferSelf() public {
        address owner = this.firefly_genAddress();
        uint256 initSupply = this.firefly_genUint256();

        ERC20 token = new ERC20("gold", "GLD", owner, initSupply);

        address from  = address(this);
        address to    = address(this);
        uint256 value = this.firefly_genUint256();

        uint256 bal = token.balanceOf(from);
        require(value <= bal);

        require(token.transfer(to, value));

        uint256 balAfter = token.balanceOf(from);

        assert(balAfter == bal);
    }

    function _testTransferFail() public {
        address owner = this.firefly_genAddress();
        uint256 initSupply = this.firefly_genUint256();

        ERC20 token = new ERC20("gold", "GLD", owner, initSupply);

        address from  = address(this);
        address to    = this.firefly_genAddress();
        uint256 value = this.firefly_genUint256();

        require(from != to);

        uint256 balFrom = token.balanceOf(from);
        require(value > balFrom);

        assert(!token.transfer(to, value));
    }
}
