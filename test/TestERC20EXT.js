const ERC20EXT = artifacts.require('ERC20EXT');
const truffleAssert = require('truffle-assertions');

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

    it("Call owner only functions", async () => {
        const erc20ext = await ERC20EXT.new("Gold", "GLD", accounts[0], 1000);
        assert.equal(await erc20ext.displayName(), "Gold");
    });

    it("Transfer to zero address fails", async () => {
        const erc20ext = await ERC20EXT.new("Gold", "GLD", accounts[0], 1000);
        await truffleAssert.reverts(erc20ext.transfer('0x0000000000000000000000000000000000000000', 10), "transfer to the zero address");
    });

});
