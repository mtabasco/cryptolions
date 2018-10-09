module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // for more about customizing your Truffle configuration!
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8547,
      network_id: "22557", 
      gas: 4700000
    },

    ganache: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "5777", 
      gas: 6721975
    }
  }
};
