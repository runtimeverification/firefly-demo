pragma solidity >=0.6.0;

import "./firefly/FireflyCheck.sol";
import "../contracts/ERC20.sol";

contract TestERC20Firefly_Transfer is FireflyCheck {
    ERC20 token;

    function beforeEach() public {
        address owner = this.firefly_genAddress();
        uint256 initSupply = this.firefly_genUint256();

        token = new ERC20("gold", "GLD", owner, initSupply);
    }

    function _testTransfer() public {
        address from  = address(this);
        address to    = this.firefly_genAddress();
        uint256 value = this.firefly_genUint256();

        this.firefly_require(from != to);

        uint256 balFrom = token.balanceOf(from);
        uint256 balTo   = token.balanceOf(to);
        this.firefly_require(balFrom - value <= balFrom || balTo + value >= balTo); // No overflows

        try token.transfer(to, value) {
            uint256 balFromAfter = token.balanceOf(from);
            uint256 balToAfter   = token.balanceOf(to);

            this.firefly_assert(balFrom    - balFromAfter == value);
            this.firefly_assert(balToAfter - balTo        == value);
        } catch {
            this.firefly_assert(false);
        }
    }

    function _testTransferOverflow() public {
        address from  = address(this);
        address to    = this.firefly_genAddress();
        uint256 value = this.firefly_genUint256();

        this.firefly_require(from != to);

        uint256 balFrom = token.balanceOf(from);
        uint256 balTo   = token.balanceOf(to);
        this.firefly_require(balFrom - value > balFrom || balTo + value < balTo); // Overflows

        try token.transfer(to, value) {
            this.firefly_assert(false);
        } catch {
            uint256 balFromAfter = token.balanceOf(from);
            uint256 balToAfter   = token.balanceOf(to);

            this.firefly_assert(balFrom    == balFromAfter);
            this.firefly_assert(balToAfter == balTo       );
        }
    }

    function _testTransferSelf() public {
        address from  = address(this);
        address to    = address(this);
        uint256 value = this.firefly_genUint256();

        uint256 bal = token.balanceOf(from);
        this.firefly_require(value <= bal);

        try token.transfer(to, value) {
            uint256 balAfter = token.balanceOf(from);
            this.firefly_assert(balAfter == bal);
        } catch {
            this.firefly_assert(false);
        }
    }

    function _testTransferFail() public {
        address from  = address(this);
        address to    = this.firefly_genAddress();
        uint256 value = this.firefly_genUint256();

        this.firefly_require(from != to);

        uint256 balFrom = token.balanceOf(from);
        this.firefly_require(value > balFrom);

        try token.transfer(to, value) {
            this.firefly_assert(false);
        } catch {
            this.firefly_assert(true);
        }
    }
}
