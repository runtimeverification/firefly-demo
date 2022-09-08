const ERC20 = artifacts.require('ERC20');

contract('ERC20', accounts => {
    it("Initial mint works", async () => {
        const erc20 = await ERC20.new("Gold", "GLD", accounts[0], 1000);
        assert.equal(await erc20.balanceOf(accounts[0]), 1000);
    });

    it("Transfer decreases/increases amount", async () => {
        const erc20 = await ERC20.new("Gold", "GLD", accounts[0], 1000);
        await erc20.transferFrom(accounts[0], accounts[1], 10);
        assert.equal(await erc20.balanceOf(accounts[0]), 990);
        assert.equal(await erc20.balanceOf(accounts[1]), 10);
    });

    it("Total supply stays constant", async () => {
        const erc20 = await ERC20.new("Gold", "GLD", accounts[0], 1000);
        await erc20.transferFrom(accounts[0], accounts[1], 10);
        assert.equal(await erc20.totalSupply(), 1000);
    });

    it("Correctly increase and decrease the allowance", async () => {
        const erc20 = await ERC20.new("Gold", "GLD", accounts[0], 1000);
        assert.equal(await erc20.allowance(accounts[0], accounts[1]), 0);
        await erc20.increaseAllowance(accounts[1], 200);
        assert.equal(await erc20.allowance(accounts[0], accounts[1]), 200);
        await erc20.decreaseAllowance(accounts[1], 100);
        assert.equal(await erc20.allowance(accounts[0], accounts[1]), 100);
    })
});