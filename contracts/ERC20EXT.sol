pragma solidity ^0.5.16;
import "./ERC20.sol";

contract ERC20EXT is ERC20 {
    constructor(
        string memory name,
        string memory symbol,
        address initAccount,
        uint256 initSupply
    ) public ERC20(name, symbol, initAccount, initSupply) {
        // solhint-disable-previous-line no-empty-blocks
    }

    function mint(address account, uint256 amount) public returns (bool) {
        _mint(account, amount);
        return true;
    }

    function burn(address account, uint256 amount) public returns (bool) {
        _burn(account, amount);
        return true;
    }
}
