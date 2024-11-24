// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FactionLeads is ERC721, Ownable {
    // Token ID counter
    uint256 private _tokenIDCounter;

    // Mapping to track if an address already owns a token
    mapping(address => bool) private _hasToken;

    // Events
    event TokenAssigned(address indexed to, uint256 indexed tokenID);
    event TokenRevoked(address indexed from, uint256 indexed tokenID);

    constructor() ERC721("FactionLeads", "MHF") {}

    // Assign a token to a Faction Lead
    function assignToken(address to) external onlyOwner {
        require(to != address(0), "Cannot assign to the zero address");
        require(!_hasToken[to], "Address already has a token");

        uint256 tokenID = _tokenIDCounter;
        _tokenIDCounter++;
        _safeMint(to, tokenID);
        _hasToken[to] = true;

        emit TokenAssigned(to, tokenID);
    }

    // Revoke a token from a Faction Lead
    function revokeToken(uint256 tokenID) external onlyOwner {
        require(_exists(tokenID), "Token does not exist");

        address owner = ownerOf(tokenID);
        _burn(tokenID);
        _hasToken[owner] = false;

        emit TokenRevoked(owner, tokenID);
    }

    // Batch assign tokens
    function batchAssignTokens(
        address[] calldata recipients
    ) external onlyOwner {
        require(recipients.length > 0, "No recipients provided");
        for (uint256 i = 0; i < recipients.length; i++) {
            assignToken(recipients[i]);
        }
    }

    // Batch revoke tokens
    function batchRevokeTokens(uint256[] calldata tokenIDs) external onlyOwner {
        require(tokenIDs.length > 0, "No token IDs provided");
        for (uint256 i = 0; i < tokenIDs.length; i++) {
            revokeToken(tokenIDs[i]);
        }
    }

    // Override to prevent transferring tokens
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenID,
        uint256 batchSize
    ) internal override {
        super._beforeTokenTransfer(from, to, tokenID, batchSize);

        require(
            from == address(0) || to == address(0),
            "Transfers are not allowed"
        );
    }
}
