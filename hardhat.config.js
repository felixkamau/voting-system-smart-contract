require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
  namedAccount: {
    deployer:{
      default: 0,  //select the first account to deploy the smart contract
    }
  },
  networks:{
    localhost:{
      url: "http://127.0.0.1:8545" //local Tson RPC node 
    },
    sepolia: {
      url: ''
    }
  }
};
