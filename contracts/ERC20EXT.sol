pragma solidity >=0.6.0;
import "./ERC20.sol";

contract ERC20EXT is ERC20 {
    // Prices how much scaled ERC20EXT you get for one unscaled ERC20
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
        uint256 mintAmount = (amountERC20 * price()) /(10 ** _otherContract.decimals());
        _mint(msg.sender, mintAmount);
    }

    function withdraw(uint256 amountERC20EXTINT ) external {
        uint256 amountERC20EXT = amountERC20EXTINT * (10 ** decimals());
        _burn(msg.sender, amountERC20EXT);
        uint256 transferAmount = ((10 ** _otherContract.decimals()) * amountERC20EXT) / price();
        _otherContract.transfer(msg.sender, transferAmount);
    }
}