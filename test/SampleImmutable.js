const SampleImutable = artifacts.require('SampleImmutable');

contract('Sample Immutable', accounts => {
    it("Should deploy and retrieve the same value", async () => {
        const value = Number.MAX_SAFE_INTEGER - 1;
        const sample = await SampleImutable.new(value);
        assert.equal(await sample.getImmutable(), value);
    });

    it("Should run sumToImmutable correctly", async () => {
        const value = 10;
        const sum = 55;
        const sample = await SampleImutable.new(value);
        assert.equal(await sample.sumToImmutable(), sum);
    });

    it("Should run storeAtImmutable correctly", async () => {
        const value = 16161;
        const sample = await SampleImutable.new(value);
        assert.equal(await sample.readAtImmutable(), 0, "Initial read failed");
        await sample.storeAtImmutable(25);
        assert.equal(await sample.readAtImmutable(), 25, "Final read failed");
    });
});