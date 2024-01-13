# Verifiable Random Function (VRF) Oracle Contract

## Introduction
The `RandomNumberConsumer` contract utilizes Chainlink's Oracle Verifiable Random Function (VRF) to provide secure and verifiable random numbers, crucial for decentralized applications needing randomness, such as in gaming or lotteries.

## Contract Features
- Integration with Chainlink VRF for random number generation.
- Management of random number requests and their fulfillment status.
- Configurable parameters for VRF requests.

## Key Concepts
### Verifiable Random Function (VRF)
Chainlink VRF provides cryptographically secure randomness by combining block data unknown when the request is made with the oracle node's pre-committed private key. More on VRF: [Chainlink VRF](https://docs.chain.link/vrf)

### Oracle
An oracle is a bridge between blockchain and external systems, enabling smart contracts to work with real-world data. In the context of Chainlink VRF, the oracle provides a reliable way to introduce randomness into the smart contract. More on Oracles: [Chainlink Oracle](https://chain.link/education/blockchain-oracles)

### Random Number Generation in Blockchain
Secure random number generation is a critical component in decentralized applications. However, blockchain's deterministic nature makes generating randomness within the blockchain challenging. External solutions like Chainlink VRF are essential for true randomness.

## Installation and Usage
Ensure you have Solidity 0.8.x or higher and access to Chainlink contracts. Deploy the `RandomNumberConsumer` contract using your preferred development environment and tools.
Connect to oracle and create consumer and subscription with LINK funded.

## Contributing

Contributions to expand or improve the repository are welcome! 

[@denizumutdereli](https://www.linkedin.com/in/denizumutdereli)