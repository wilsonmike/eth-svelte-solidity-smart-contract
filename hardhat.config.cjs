require('@nomiclabs/hardhat-waffle');
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  paths: {
    artifacts: './src/artifacts',
    sources: './src/contracts'
  },
  networks: {
    hardhat: {
      chainId: 1337
    }
  }
};
