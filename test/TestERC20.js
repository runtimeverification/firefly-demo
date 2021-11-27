const {expectRevert} = require('@openzeppelin/test-helpers');
const ERC20 = artifacts.require('ERC20');

contract('ERC20', accounts => {
    
    beforeEach(async() => {
         this.erc20 = await ERC20.new("Gold", "GLD", accounts[0], 1000, 2);
    });

    it("Initial mint works", async () => {
        assert.equal(await this.erc20.balanceOf(accounts[0]), 1000);
        assert.equal(await this.erc20.totalSupply(), 1000);
    });

    it("TransferFrom different accounts", async () => {
        await this.erc20.approve(accounts[0], 600);
        await this.erc20.transferFrom(accounts[0], accounts[1], 600);
        assert.equal(await this.erc20.balanceOf(accounts[0]), 400);
        assert.equal(await this.erc20.balanceOf(accounts[1]), 600);
    });

    it("TransferFrom same account", async () => {
        await this.erc20.approve(accounts[0], 600);
        await expectRevert(this.erc20.transferFrom(accounts[0], accounts[0], 600), " ERC20: Cannot send to the same account?");
    });

    it("Total supply should stay the same", async () => {
        await this.erc20.approve(accounts[0], 600);
        await this.erc20.transferFrom(accounts[0], accounts[1], 600);
        assert.equal(await this.erc20.balanceOf(accounts[0]), 400);
        assert.equal(await this.erc20.balanceOf(accounts[1]), 600);
        assert.equal(await this.erc20.totalSupply(), 1000);
    });
});