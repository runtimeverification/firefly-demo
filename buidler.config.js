usePlugin("@nomiclabs/buidler-truffle5");

module.exports = {
    solc: {
        version: "0.6.12"
    },
    networks: {
        localhost: {
            url: "http://127.0.0.1:8145"
        }
    }
};
