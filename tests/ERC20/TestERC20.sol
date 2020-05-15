pragma solidity ^0.5.8;

import "truffle/Assert.sol";
import "../contracts/ERC20.sol";

contract TestERC20 {
  function testgetMint() public {
    address acct1 = address(0x01);
    address acct2 = address(0x02);
    ERC20 erc20 = new ERC20("Gold", "GLD", acct1, 1000);
    Assert.equal(erc20.balanceOf(acct1), 1000, "initial mint works");
    erc20.transferFrom(acct1, acct2, 10);
    Assert.equal(erc20.balanceOf(acct1), 990, "transfer decreases amount");
    Assert.equal(erc20.balanceOf(acct2), 10, "transfer increases amount");
    Assert.equal(erc20.totalSupply(), 1000, "total supply stays constant");
  }
}
