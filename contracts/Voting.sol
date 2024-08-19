// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Voting is Ownable {
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    struct Voter {
        bool hasVoted;
        uint256 vote;
    }

    Candidate[] public candidates;
    mapping(address => Voter) public voters;
    bool public votingActive;

    // Add events
    event CandidateAdded(string name);
    event VoteCasted(address voter, uint256 candidateId);
    event VotingStarted();
    event VotingEnded();

    modifier onlyWhenVotingActive() {
        require(votingActive, "Voting is not active");
        _;
    }

    modifier hasNotVoted() {
        require(!voters[msg.sender].hasVoted, "You have alredy voted");
        _;
    }

    // Constructor to optionally initialize the contract with candidates
    constructor(string[] memory _candidateNames) Ownable(msg.sender) {
        if (_candidateNames.length > 0) {
            for (uint256 i = 0; i < _candidateNames.length; i++) {
                candidates.push(Candidate(_candidateNames[i], 0));
                // emit the event CandidateAdded
                emit CandidateAdded(_candidateNames[i]);
            }
        }
    }

    // Function to add candidate
    function addCandidate(string memory _name) external onlyOwner {
        candidates.push(Candidate(_name, 0));
        emit CandidateAdded(_name);
    }

    // Function to toggle voting/start voting process
    function startVoting() external onlyOwner {
        votingActive = true;
        emit VotingStarted();
    }

    // Function to end voting process
    function endVoting() external onlyOwner {
        votingActive = false;
        emit VotingEnded();
    }

    function vote(uint256 _candidateId)
        external
        onlyWhenVotingActive
        hasNotVoted
    {
        // check if the candidateId is not greater the candiates length
        require(_candidateId < candidates.length, "Invalid Candidate ID");

        voters[msg.sender] = Voter(true, _candidateId);
        candidates[_candidateId].voteCount++;
        emit VoteCasted(msg.sender, _candidateId);
    }

    // Get vote of a certain candidate
    function getVotes(uint256 _candidateId) external view returns (uint256) {
        require(_candidateId < candidates.length, "Invalid Candidate ID");

        return candidates[_candidateId].voteCount;
    }

    // get the winner
    function getWinner() external view returns (string memory winnerName) {
        require(!votingActive, "Voting has not ended yet");
        uint256 maxVotes = 0;
        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winnerName = candidates[i].name;
            }
        }
    }
}
