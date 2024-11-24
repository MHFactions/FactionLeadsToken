# FactionLeadsToken
This repository contains the Solidity smar contract `FactionLeads.sol`, a custom ERC-721 token contract deisgned for managing Faction Leads within the MCW. The token allows for controlled minting, revocation, and batch operations, making it suitable for token-gated functionalities such as Discord role access or exclusive website features.

## Features
- **Token Assignment:** Only the contract owner can assign tokens to Faction Leads.
- **Revocation:** Tokens can be revoked by the onwer, and revoked tokens are burned.
- **Batch Operations:** Easily assign or revoke tokens in bulk.
- **Non-Transferable:** Tokens cannot be transferred between addresses, ensuring control over the token's intended use.
- **Event Emission:** Logs all token assignment and revocations for transparency.

## Folder Structure
```
FactionLeadsToken/
├── contracts/
│   └── FactionLeads.sol    # The main smart contract
├── package.json            # Project metadata and dependencies
├── package-lock.json       # Dependency version lock file
```

## Smart Contract Overview
### Contract Name
`FactionLeads`
### Symbol
`MHF`
### Owner-Only Functions
+ Assign tokens to specific addresses.
+ Revoke tokens (burning them in the process).
+ Perform batch operations for efficiency.
### Transfer Restrictions
Tokens are non-transferable. Transfers are restricted to minting (`from == address(0)`) and burning (`to == address(0)`).

## Dependencies
+ [Openzeppelin-Contracts](https://github.com/OpenZeppelin/openzeppelin-contracts): Used for secure and reusable implementation of ERC-721 and ownership patterns.

To install OpenZeppelin dependencies:
```bash
npm install @openzeppelin/contracts
```


