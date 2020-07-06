pragma solidity ^0.5.8;
import "truffle/Assert.sol";
import "../contracts/ERC20.sol";
import "../contracts/ERC20EXT.sol";
contract TestERC20EXT {
  function testmint() public {
    address acct1 = address(0x01);
    ERC20EXT erc20ext = new ERC20EXT("Gold", "GLD", acct1, 1000);
    Assert.equal(erc20ext.balanceOf(acct1), 1000, "initial mint works");
    erc20ext.mint(acct1, 100);
    Assert.equal(erc20ext.balanceOf(acct1), 1100, "mint increases amount");
  }
}
