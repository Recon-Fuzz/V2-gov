# Contract: HookMiner

## Metadata

- **Name**: HookMiner
- **Type**: Contract
- **Path**: script/utils/HookMiner.sol
- **Documentation**: @title HookMiner - a library for mining hook addresses
   @dev This library is intended for `forge test` environments. There may be gotchas when using salts in `forge script` or `forge create`

## State Variables

### FLAG_MASK

```solidity
uint160 internal constant FLAG_MASK = 0x3FFF
```

### MAX_LOOP

```solidity
uint256 internal constant MAX_LOOP = 100_000
```
