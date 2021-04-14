const SampleImutable = artifacts.require('SampleImmutable');

contract('Sample Immutable', accounts => {
    it("Should deploy and retrieve the same value", async () => {
        const value = 10;
        const sample = await SampleImutable.new(value);
        assert.equal(await sample.getImmutable(), value);
    })
});