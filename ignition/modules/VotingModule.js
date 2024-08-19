const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("VotingModule", (m) => {
    // Array of candidates can be empty or predefined
    const candidateNames = [];
    const voting = m.contract('Voting',[candidateNames])
    return {voting};
});


