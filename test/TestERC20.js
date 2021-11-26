const ERC20 = artifacts.require('ERC20');

contract('ERC20', accounts => {
    it("Initial mint works", async () => {
        const erc20 = await ERC20.new("Gold", "GLD", accounts[0], 1000, 18);
        assert.equal(await erc20.balanceOf(accounts[0]), 1000);
        assert.equal(await erc20.totalSupply(), 1000);
    });

});