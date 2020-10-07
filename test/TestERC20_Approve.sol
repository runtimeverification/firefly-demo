pragma solidity >=0.6.0;

import "./firefly/FireflyCheck.sol";
import "../contracts/ERC20.sol";

contract TestERC20Firefly_Approve is FireflyCheck {
    function _testApproveAllowance() public {
        address owner = this.firefly_genAddress();
        uint256 initSupply = this.firefly_genUint256();

        ERC20 token = new ERC20("gold", "GLD", owner, initSupply);

        address spender = this.firefly_genAddress();
        uint256 value = this.firefly_genUint256();

        this.firefly_require(token.approve(spender, value));

        this.firefly_assert(token.allowance(address(this), spender) == value);
    }

    function _testApproveOther() public {
        address owner = this.firefly_genAddress();
        uint256 initSupply = this.firefly_genUint256();

        ERC20 token = new ERC20("gold", "GLD", owner, initSupply);

        address spender = this.firefly_genAddress();
        uint256 value = this.firefly_genUint256();

        address nonCaller = this.firefly_genAddress();
        this.firefly_require(nonCaller != address(this));

        address any = this.firefly_genAddress();
        uint256 otherAllowance = token.allowance(nonCaller, any);

        this.firefly_require(token.approve(spender, value));

        this.firefly_assert(token.allowance(nonCaller, any) == otherAllowance); // Allowance doesn't change
    }
}
