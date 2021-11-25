// SPDX-License-Identifier: Just something to remove the warning

pragma solidity >=0.6.0;
import "./ERC20.sol";



contract ERC20EXT is ERC20 {
    // Prices how much ERC20EXT you get for one ERC20
    uint256 private _price;
    ERC20 private _otherContract;

    constructor (
        string memory name
      , string memory symbol
      , address initAccount
      , uint256 initSupply
      , uint8 decimals
      , address otherContract
      , uint256 price
      ) public ERC20(name, symbol, initAccount, initSupply, decimals) {
        _otherContract = ERC20(otherContract);
        _price = price;
    }

    function price() public view returns (uint256) { return _price; }

    function deposit(uint256 amountERC20INT) external {
        uint256 amountERC20 = amountERC20INT * (10 ** _otherContract.decimals());
        _otherContract.transferFrom(msg.sender, address(this), amountERC20);
        uint256 mintAmount = (amountERC20 * price())/ (10 ** _otherContract.decimals());
        _mint(msg.sender, mintAmount);
    }

    function withdraw(uint256 amountERC20EXTINT ) external {
        _burn(msg.sender, (10 ** decimals()) * amountERC20EXTINT);
        uint256 amountERC20EXT = amountERC20EXTINT * (10 ** _otherContract.decimals());
        uint256 transferAmount = ((10 ** decimals()) * amountERC20EXT )/ price();
        _otherContract.transfer(msg.sender, transferAmount);
    }
}