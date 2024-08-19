# Voting Smart Contract Solidity

## Description

This repository contains a Hardhat project for a decentralized voting system smart contract. The `Voting` contract uses OpenZeppelin's `Ownable` for ownership management and supports candidate registration, voting, and winner determination. The project includes deployment scripts using Hardhat Ignition and testing.

## Features

- **Candidate Registration**: Add and manage candidates.
- **Voting**: Users can vote for candidates.
- **Winner Determination**: Determine the candidate with the most votes.
- **Deployment**: Uses Hardhat Ignition for deployment.
- **Testing**: Includes tests to verify contract functionality.

## Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/) (v18 or later recommended)
- [Hardhat](https://hardhat.org/)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/4.x/)

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/yourusername/hardhat-voting-system.git
    cd hardhat-voting-system
    ```

2. Install dependencies:

    ```bash
    npm install
    ```

### Running Tests

Run the following command to execute tests:

```bash
npx hardhat test
```

### Deployment

Deploy the contract to a local Hardhat network:

1. Start Hardhat Network:

    ```bash
    npx hardhat node
    ```

2. Deploy Contract:

    In a new terminal, run:

    ```bash
    npx hardhat ignition deploy ./ignition/modules/VotingSystem.js --network localhost
    ```
