// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TokenRegistry {

    struct Token {
        string name;
        string symbol;
        address owner;
        bool isActive;
    }

    // Mapping from token ID to Token
    mapping(uint256 => Token) public tokens;

    // Array to track all token IDs
    uint256[] public tokenIds;

    // Auto-increment token ID counter
    uint256 private nextId = 1;

    // Event for new token registration
    event TokenRegistered(
        uint256 indexed id,
        string name,
        string symbol,
        address indexed owner
    );

    // Modifier to check token exists
    modifier tokenExists(uint256 id) {
        require(id > 0 && id < nextId, "Token does not exist");
        _;
    }

    // Modifier to check token owner
    modifier onlyOwner(uint256 id) {
        require(tokens[id].owner == msg.sender, "Not token owner");
        _;
    }

    // Register a new token
    function registerToken(string memory name, string memory symbol) public {
        require(bytes(name).length > 0, "Name cannot be empty");
        require(bytes(symbol).length > 0, "Symbol cannot be empty");

        uint256 id = nextId;

        tokens[id] = Token({
            name: name,
            symbol: symbol,
            owner: msg.sender,
            isActive: true
        });

        tokenIds.push(id);

        emit TokenRegistered(id, name, symbol, msg.sender);

        nextId++;
    }

    // Deactivate a token (only owner)
    function deactivateToken(uint256 id)
        public
        tokenExists(id)
        onlyOwner(id)
    {
        tokens[id].isActive = false;
    }

    // Get token details
    function getToken(uint256 id)
        public
        view
        tokenExists(id)
        returns (
            string memory name,
            string memory symbol,
            address owner,
            bool isActive
        )
    {
        Token memory t = tokens[id];
        return (t.name, t.symbol, t.owner, t.isActive);
    }

    // Get all token IDs
    function getAllTokenIds() public view returns (uint256[] memory) {
        return tokenIds;
    }
}
