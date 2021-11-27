const {expectRevert} = require('@openzeppelin/test-helpers');
const { inTransaction } = require('@openzeppelin/test-helpers/src/expectEvent');
const { erc20 } = require('./TestERC20');
const ERC20 = artifacts.require('ERC20');
const ERC20EXT = artifacts.require('ERC20EXT');

contract('ERC20', accounts => {
    it(" Behaves correctly when price is lower than 1", async () => {
        const erc20 = await ERC20.new("Gold", "GLD", accounts[0], 1000, 2);
        const erc20ext = await ERC20EXT.new("Rocks", "RCK", accounts[0], 100000 , 4, erc20.address, 351);
        await erc20.approve(erc20ext.address, 300);
        await erc20ext.deposit(3);
        assert.equal(await erc20.balanceOf(erc20ext.address), 300);
        assert.equal(await erc20.balanceOf(accounts[0]), 700);
        assert.equal((await erc20ext.balanceOf(accounts[0])).toString(), '101053'); //BUG1 catcher
        assert.equal(await erc20.totalSupply(), 1000);
        assert.equal(await erc20ext.totalSupply(), 101053);


    });

});
