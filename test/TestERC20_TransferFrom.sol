pragma solidity >=0.6.0;

import "./firefly/FireflyCheck.sol";
import "../contracts/ERC20.sol";

contract TestERC20Firefly_TransferFrom is FireflyCheck {
    ERC20 token;

    function beforeEach() public {
        address owner = this.firefly_genAddress();
        uint256 initSupply = this.firefly_genUint256();

        token = new ERC20("gold", "GLD", owner, initSupply);
    }

    function _testTransferFrom() public {
        address from    = this.firefly_genAddress();
        address to      = this.firefly_genAddress();
        address spender = address(this);
        uint256 value   = this.firefly_genUint256();

        uint256 allowance = token.allowance(from, spender);
        uint256 balFrom = token.balanceOf(from);
        uint256 balTo = token.balanceOf(to);
        this.firefly_require(from != to);
        this.firefly_require(value <= allowance);
        this.firefly_require(balFrom - value <= balFrom || balTo + value >= balTo); // No Overflow

        try token.transferFrom(from, to, value) {
            this.firefly_assert(allowance == token.allowance(from, spender) - value);
            this.firefly_assert(balTo >= token.balanceOf(to));
        } catch {
            this.firefly_assert(false);
        }
    }

    function _testTransferFromOverflow() public {
        address from    = this.firefly_genAddress();
        address to      = this.firefly_genAddress();
        address spender = address(this);
        uint256 value   = this.firefly_genUint256();

        uint256 allowance = token.allowance(from, spender);
        uint256 balFrom = token.balanceOf(from);
        uint256 balTo = token.balanceOf(to);
        this.firefly_require(from != to);
        this.firefly_require(value <= allowance);
        this.firefly_require(balFrom - value > balFrom || balTo + value < balTo); // No Overflow

        try token.transferFrom(from, to, value) {
            this.firefly_assert(false);
        } catch {
            this.firefly_assert(allowance == token.allowance(from, spender));
            this.firefly_assert(balTo == token.balanceOf(to));
        }
    }

    function _testTransferFromFailure() public {
        address from    = this.firefly_genAddress();
        address to      = this.firefly_genAddress();
        address spender = address(this);
        uint256 value   = this.firefly_genUint256();

        uint256 allowance = token.allowance(from, spender);
        this.firefly_require(from != to);
        this.firefly_require(value > allowance);

        try token.transferFrom(from, to, value) {
            this.firefly_assert(false);
        } catch {
            this.firefly_assert(true);
        }
    }

    function _testTransferFromSelf() public {
        address from    = this.firefly_genAddress();
        address to      = from;
        address spender = address(this);
        uint256 value   = this.firefly_genUint256();

        uint256 allowance = token.allowance(from, spender);
        uint256 bal = token.balanceOf(to);
        this.firefly_require(value <= allowance);

        try token.transferFrom(from, to, value) {
            this.firefly_assert(allowance == token.allowance(from, spender) - value);
            this.firefly_assert(bal == token.balanceOf(to));
        } catch {
            this.firefly_assert(false);
        }
    }
}
