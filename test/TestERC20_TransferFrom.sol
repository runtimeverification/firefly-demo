pragma solidity >=0.5.16;

import "./firefly/FireflyCheck.sol";
import "../contracts/ERC20.sol";

contract TestERC20Firefly_TransferFrom is FireflyCheck {
    function _testTransferFrom() public {
        address owner = this.firefly_genAddress();
        uint256 initSupply = this.firefly_genUint256();

        ERC20 token = new ERC20("gold", "GLD", owner, initSupply);

        address from    = this.firefly_genAddress();
        address to      = this.firefly_genAddress();
        address spender = address(this);
        uint256 value   = this.firefly_genUint256();

        uint256 allowance = token.allowance(from, spender);
        uint256 bal = token.balanceOf(to);
        require(from != to);
        require(value <= allowance);

        token.transferFrom(from, to, value);

        assert(allowance == token.allowance(from, spender) - value);
        assert(bal >= token.balanceOf(to));
    }

    function _testTransferFromFailure() public {
        address owner = this.firefly_genAddress();
        uint256 initSupply = this.firefly_genUint256();

        ERC20 token = new ERC20("gold", "GLD", owner, initSupply);

        address from    = this.firefly_genAddress();
        address to      = this.firefly_genAddress();
        address spender = address(this);
        uint256 value   = this.firefly_genUint256();

        uint256 allowance = token.allowance(from, spender);
        require(from != to);
        require(value > allowance);

        assert(!token.transferFrom(from, to, value));
    }

    function _testTransferFromSelf() public {
        address owner = this.firefly_genAddress();
        uint256 initSupply = this.firefly_genUint256();

        ERC20 token = new ERC20("gold", "GLD", owner, initSupply);

        address from    = this.firefly_genAddress();
        address to      = from;
        address spender = address(this);
        uint256 value   = this.firefly_genUint256();

        uint256 allowance = token.allowance(from, spender);
        uint256 bal = token.balanceOf(to);
        require(value <= allowance);

        token.transferFrom(from, to, value);

        assert(allowance == token.allowance(from, spender) - value);
        assert(bal == token.balanceOf(to));
    }
}
