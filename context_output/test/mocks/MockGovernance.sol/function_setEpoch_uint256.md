# Function: setEpoch(uint256)

**Contract**: [test/mocks/MockGovernance.sol/contract_MockGovernance.md]

## Metadata

- **Contract**: MockGovernance
- **Signature**: `setEpoch(uint256)`
- **Visibility**: external
- **Source Range**: 330:76:111

## Implementation

```solidity
function setEpoch(uint256 _epoch) external {
    __epoch = _epoch;
}
```

## State Variable Writes

- **__epoch** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockGovernance.setEpoch(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
