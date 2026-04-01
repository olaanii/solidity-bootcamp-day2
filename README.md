# TokenRegistry Smart Contract

A simple Solidity smart contract for registering and managing tokens on the blockchain. Built as part of the Solidity Bootcamp (Day 2).

---

## 📌 Overview

The `TokenRegistry` contract allows users to:

- Register new tokens
- Store token details on-chain
- Deactivate tokens (only by owner)
- Retrieve token information
- Track all registered token IDs

---

## 🏗️ Contract Features

### 1. Token Structure

Each token is represented using a struct:

- `name` → Token name
- `symbol` → Token symbol
- `owner` → Address of the creator
- `isActive` → Status of the token

---

### 2. Storage

- `mapping(uint256 => Token)` → Stores tokens by unique ID
- `uint256[] tokenIds` → Tracks all registered token IDs
- `uint256 nextId` → Auto-incrementing token ID

---

### 3. Core Functions

#### ✅ `registerToken(string name, string symbol)`
- Registers a new token
- Assigns a unique ID
- Sets the caller as owner
- Marks token as active
- Emits `TokenRegistered` event

#### ✅ `deactivateToken(uint256 id)`
- Deactivates a token
- Only callable by the token owner

#### ✅ `getToken(uint256 id)`
- Returns:
  - name
  - symbol
  - owner
  - isActive

#### ✅ `getAllTokenIds()`
- Returns all registered token IDs

---

## 🔔 Events

### `TokenRegistered`
Emitted when a new token is created.

```solidity
event TokenRegistered(
    uint256 indexed id,
    string name,
    string symbol,
    address indexed owner
);
