# ERC20 Token Project

A simple and secure ERC20 token implementation built with Solidity and using Foundry for development and testing.

## Overview

This project implements a standard ERC20 token using OpenZeppelin's battle-tested contracts. The token includes all standard ERC20 functionality including transfers, approvals, and allowances.

## Features

- Standard ERC20 implementation
- OpenZeppelin base contracts for security
- Comprehensive test suite
- Foundry development environment
- Gas-efficient operations

## Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation.html)
- [Git](https://git-scm.com/downloads)

## Installation

1. Clone the repository:
```bash
git clone https://github.com/Akkii4/foundry-erc20
cd erc20-token
```

2. Install dependencies:
```bash
forge install
```

## Project Structure

```
.
├── src/
│   └── Token.sol        # Main token contract
├── test/
│   └── Token.t.sol      # Test suite
├── script/
│   └── Token.s.sol      # Deployment script
└── README.md
```

## Smart Contracts

### Token.sol
The main ERC20 token contract inherits from OpenZeppelin's ERC20 implementation:
- Name: "Token"
- Symbol: "TKN"
- Decimals: 18
- Initial Supply: Set during deployment

## Testing

The project includes a comprehensive test suite covering:
- Basic token properties
- Transfer functionality
- Approval mechanism
- Allowance management
- Edge cases and fuzzing tests

To run the tests:

```bash
# Run all tests
forge test

# Run tests with verbosity
forge test -vv

# Run tests with gas reporting
forge test --gas-report

# Run specific test
forge test --match-test testTransfer
```

## Deployment

1. Set up your environment variables:
```bash
cp .env.example .env
# Edit .env with your configuration
```

2. Deploy to a network:
```bash
# Local deployment
forge script script/Token.s.sol:TokenScript --rpc-url localhost --broadcast

# Testnet deployment
forge script script/Token.s.sol:TokenScript --rpc-url $RPC_URL --broadcast --verify -vvvv
```

## Security

- Built on OpenZeppelin's audited contracts
- Comprehensive test coverage
- Standard ERC20 implementation

## Gas Optimization

The contract is optimized for gas efficiency while maintaining security:
- Uses OpenZeppelin's optimized implementations
- Minimal storage operations
- Efficient function implementations

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- OpenZeppelin for their secure contract implementations
- Foundry for the development framework
- The Ethereum community for their continuous support