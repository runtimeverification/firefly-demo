// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.0;

contract StandardToken {
	uint256 supply;
	mapping (address => uint256) balance;
	mapping (address =>
		mapping (address => uint256)) m_allowance;

	constructor(address _initialOwner, uint256 _supply) {
		supply = _supply;
		balance[_initialOwner] = _supply;
	}

	function balanceOf(address _account) public view returns (uint256) {
		return balance[_account];
	}

	function totalSupply() public view returns (uint256) {
		return supply;
	}

	function allowance(address _owner, address _spender) public view returns (uint256) {
		return m_allowance[_owner][_spender];
	}

	function transfer(address _to, uint256 _value) public returns (bool success) {
		return doTransfer(msg.sender, _to, _value);
	}

	function approve(address _spender, uint256 _value) public returns (bool success) {
		m_allowance[msg.sender][_spender] = _value;
		return true;
	}

	function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
		if (m_allowance[_from][msg.sender] >= _value) {
			if (doTransfer(_from, _to, _value)) {
				m_allowance[_from][msg.sender] -= _value;
			}
			return true;
		} else {
			return false;
		}
	}

	function doTransfer(address _from, address _to, uint256 _value) internal returns (bool success) {
		if (balance[_from] >= _value && balance[_to] + _value >= balance[_to]) {
			balance[_from] -= _value;
			balance[_to] += _value;
			return true;
		} else {
			return false;
		}
	}
}