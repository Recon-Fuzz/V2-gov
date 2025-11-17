# Contract: MockGovernance

## Metadata

- **Name**: MockGovernance
- **Type**: Contract
- **Path**: test/mocks/MockGovernance.sol

## State Variables

### __epoch

```solidity
uint256 private __epoch
```

### EPOCH_START

```solidity
uint256 public constant EPOCH_START = 0
```

### EPOCH_DURATION

```solidity
uint256 public constant EPOCH_DURATION = 7 days
```

## Public/External Functions

### claimForInitiative(address)

- **Signature**: `claimForInitiative(address)`
- **Visibility**: external
- **Source Range**: 224:100:111
- **Details**: [function_claimForInitiative_address.md](./function_claimForInitiative_address.md)

**Signature:**
```solidity
function claimForInitiative(address) external pure returns (uint256);
```

### setEpoch(uint256)

- **Signature**: `setEpoch(uint256)`
- **Visibility**: external
- **Source Range**: 330:76:111
- **Details**: [function_setEpoch_uint256.md](./function_setEpoch_uint256.md)

**Signature:**
```solidity
function setEpoch(uint256 _epoch) external;
```

### epoch()

- **Signature**: `epoch()`
- **Visibility**: external
- **Source Range**: 412:80:111
- **Details**: [function_epoch.md](./function_epoch.md)

**Signature:**
```solidity
function epoch() external view returns (uint256);
```

### lqtyToVotes(uint256,uint256,uint256)

- **Signature**: `lqtyToVotes(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 759:259:111
- **Details**: [function_lqtyToVotes_uint256_uint256_uint256.md](./function_lqtyToVotes_uint256_uint256_uint256.md)

**Signature:**
```solidity
function lqtyToVotes(uint256 _lqtyAmount, uint256 _currentTimestamp, uint256 _averageTimestamp) public pure returns (uint256);
```
