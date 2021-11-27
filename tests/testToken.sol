// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.0;

import "contracts/Actor.sol";
import "contracts/StandardToken.sol";

// simpleTransfer(uint256,uint256) : 1000, 400 -> true, 600, 400
// simpleTransfer(uint256,uint256) : 1000, 1000 -> true, 0, 1000
// simpleTransfer(uint256,uint256) : 1000, 2000 -> false, 1000, 0
// allowanceTransfer(uint256,uint256,uint256) : 1000, 400, 300 -> true, 700, 300, 100
// allowanceTransfer(uint256,uint256,uint256) : 1000, 400, 400 -> true, 600, 400, 0
// allowanceTransfer(uint256,uint256,uint256) : 1000, 300, 400 -> false, 1000, 0, 300

contract TestToken {

  function testSimpleTransfer1() public {

    bool result1;
    uint256 result2;
    uint256 result3;
    (result1, result2, result3) = this.simpleTransfer(1000, 400);
    assert(result1 == true &&  result2 == 600 && result3 == 400);
  }

  function testSimpleTransfer2() public {

    bool result1;
    uint256 result2;
    uint256 result3;
    (result1, result2, result3) = this.simpleTransfer(1000, 1000);
    assert(result1 == true &&  result2 == 0 && result3 == 1000);
  }

  function testSimpleTransfer3() public {

    bool result1;
    uint256 result2;
    uint256 result3;
    (result1, result2, result3) = this.simpleTransfer(1000, 2000);
    assert(result1 == false &&  result2 == 1000 && result3 == 0);
  }

  function testAllowanceTransfer1 () public {
    bool result1;
    uint256 result2;
    uint256 result3;
    uint256 result4;
    (result1, result2, result3, result4) = this.allowanceTransfer(1000, 400, 300);
    assert(result1 == true &&  result2 == 700 && result3 == 300 && result4 == 100);
  }

  function testAllowanceTransfer2 () public {
    bool result1;
    uint256 result2;
    uint256 result3;
    uint256 result4;
    (result1, result2, result3, result4) = this.allowanceTransfer(1000, 400, 400);
    assert(result1 == true &&  result2 == 600 && result3 == 400 && result4 == 0);
  }

  function testAllowanceTransfer3 () public {
    bool result1;
    uint256 result2;
    uint256 result3;
    uint256 result4;
    (result1, result2, result3, result4) = this.allowanceTransfer(1000, 300, 400);
    assert(result1 == false &&  result2 == 1000 && result3 == 0 && result4 == 300);
  }

  function simpleTransfer(uint256 supply,
                          uint256 transferAmount)
    public
    returns (bool success,
              uint256 ownerBalance,
              uint256 targetBalance) {

      Actor owner = new Actor();
      StandardToken token = new StandardToken(address(owner), supply);
      owner.setToken(token);

      Actor target = new Actor();
      target.setToken(token);

      success = owner.transfer(target, transferAmount);
      ownerBalance = token.balanceOf(address(owner));
      targetBalance = token.balanceOf(address(target));
  }

  function allowanceTransfer(uint256 supply,
                              uint256 allowanceAmount,
                              uint256 transferAmount)
    public
    returns (bool success,
              uint256 ownerBalance,
              uint256 targetBalance,
              uint256 spenderAllowance) {

      Actor owner = new Actor();
      StandardToken token = new StandardToken(address(owner), supply);
      owner.setToken(token);

      Actor spender = new Actor();
      spender.setToken(token);

      Actor target = new Actor();
      target.setToken(token);

      owner.approve(spender, allowanceAmount);
      success = spender.transferFrom(owner, target, transferAmount);
      ownerBalance = token.balanceOf(address(owner));
      targetBalance = token.balanceOf(address(target));
      spenderAllowance = token.allowance(address(owner), address(spender));
  }
}
