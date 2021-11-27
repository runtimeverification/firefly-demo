// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.0;

import "contracts/StandardToken.sol";

contract Actor {
  StandardToken token;

  function setToken(StandardToken _token) public {
    token = _token;
  }

  function transfer(Actor to, uint256 value) public returns (bool) {
    return token.transfer(address(to), value);
  }

  function approve(Actor spender, uint256 value) public returns (bool) {
    return token.approve(address(spender), value);
  }

  function transferFrom(Actor from, Actor to, uint256 value) public returns (bool) {
    return token.transferFrom(address(from), address(to), value);
  }
}