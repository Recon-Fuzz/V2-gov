# Function: epoch()

**Contract**: [test/mocks/MockGovernance.sol/contract_MockGovernance.md]

## Metadata

- **Contract**: MockGovernance
- **Signature**: `epoch()`
- **Visibility**: external
- **Source Range**: 412:80:111

## Implementation

```solidity
function epoch() external view returns (uint256) {
    return __epoch;
}
```

## State Variable Reads

- **__epoch** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockGovernance.epoch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
