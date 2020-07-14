const ERC20EXT = artifacts.require('ERC20EXT');

contract('ERC20EXT', accounts => {
    it("Initial mint works", async () => {
        const erc20ext = await ERC20EXT.new("Gold", "GLD", accounts[0], 1000);
        assert.equal(await erc20ext.balanceOf(accounts[0]), 1000);
    });

    it("Transfer decreases/increases amount", async () => {
        const erc20ext = await ERC20EXT.new("Gold", "GLD", accounts[0], 1000);
        await erc20ext.transferFrom(accounts[0], accounts[1], 10);
        assert.equal(await erc20ext.balanceOf(accounts[0]), 990);
        assert.equal(await erc20ext.balanceOf(accounts[1]), 10);
    });

});